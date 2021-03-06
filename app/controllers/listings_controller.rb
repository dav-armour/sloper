class ListingsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_listing, only: [:show, :edit, :update, :destroy]
  before_action :check_permission, only: [:edit, :update, :destroy]

  # GET /listings
  def index
    # Eager load listing images for use in view and join location to get city for searching location
    @listings = Listing.includes(:listing_images).joins(:location).select("listings.*, locations.city, locations.country")

    # Search by city (Fuzzy Search)
    unless params[:city].blank?
      params[:city].strip
      @listings = @listings.references(:locations).fuzzy_search(locations: {city: "#{params[:city]}"})
    end
    # Search by category, ignore both or none checked
    if params[:ski] == '1' && params[:snowboard] == '0'
      category = "Ski"
    elsif params[:ski] == '0' && params[:snowboard] == '1'
      category = "Snowboard"
    end
    if category
      @listings = @listings.where(category: category)
    end
    # Search by type
    unless params[:item_type].blank? || params[:item_type] == 'All'
      @listings = @listings.where(item_type: "#{params[:item_type]}")
    end
    # Search by brand (Fuzzy Search)
    unless params[:brand].blank?
      params[:brand].strip
      @listings = @listings.fuzzy_search(brand: "#{params[:brand]}")
    end
    # Create select options for size
    @size_array = ["All"]
    (90...200).step(10) do |n|
      @size_array << "#{n} - #{n+9}"
    end
    # Search by size
    unless params[:size].blank? || params[:size] == 'All'
      size_range = Range.new(*params[:size].split(" - ").map(&:to_i))
      @listings = @listings.where(size: size_range)
    end
    # Search by available dates
    unless params[:start_date].blank? || params[:end_date].blank?
      begin
        # Don't allow dates in the past
        if params[:start_date].to_date < Time.now.to_date
          @listings = []
          flash[:alert] = "Search dates can't be in the past"
        elsif params[:start_date].to_date > params[:end_date].to_date
          @listings = []
          flash[:alert] = "Start date needs to be before end date"
        else
          # Make array of date range
          date_arr = (params[:start_date].to_date..params[:end_date].to_date).to_a
          # Get all list ids that have those days unavailable
          unavailable_list_ids = UnavailableDay.select(:listing_id).where(day: date_arr)
          # Exclude unavailable listings from results
          @listings = @listings.where.not(id: unavailable_list_ids)
        end
      # Rescue invalid dates
      rescue ArgumentError => e
        @listings = []
        flash[:alert] = e.message
      end
    end
    # Using count crashes fuzzy search with nested table, using size instead
    @total_listings = @listings.size
    # Retrieve Limit and Page to create pagination
    # Set default limit to 10 and max to 50
    params[:results_per_page] ||= 10
    @limit = params[:results_per_page]
    @limit = @limit.to_i
    # Force max limit of 50
    @limit = 10 unless @limit.between?(1,50)
    # Set default page to 1 and calculate offset
    params[:page] ||= 1
    page = params[:page].to_i
    # Ignore negative or zero page numbers
    page = 1 if page < 1
    @offset = (page - 1) * @limit
    # Change offset and page if not enough search results
    if @offset > @total_listings
      @offset = 0
      params[:page] = 1
    end
    # Limit SQL query to only bring back required results (Pagination)
    @listings = @listings.limit(@limit).offset(@offset) if @total_listings > 0
    # Total pages used for dropdown in view
    @pages = (@total_listings / @limit.to_f).ceil
  end

  # GET /listings/1
  def show
    @user = User.find(@listing.user_id)
    # Eager load booking and author of review for displaying in view
    @reviews = Review.includes(:booking, booking: :user).where(bookings: {listing_id: @listing.id})
    # Count all reviews and get average to display in view
    @total_reviews = @reviews.count
    @average_rating = @reviews.average(:rating)
  end

  # GET /listings/new
  def new
    @listing = Listing.new
    # Need to create location that is linked to each new listing
    @listing.location ||= Location.new
  end

  # GET /listings/1/edit
  def edit
    # Convert price to dollars for use in view
    @listing.daily_price /= 100
    @listing.weekly_price /= 100
  end

  # POST /listings
  def create
    begin
      @listing = Listing.new(listing_params)
      @listing.user_id = current_user.id
      raise ListingError, "Please fix form errors" unless @listing.valid?
      # Convert dollars to cents
      @listing.daily_price *= 100
      @listing.weekly_price *= 100
      listing_saved = @listing.save
      raise ListingError, "Couldn't save listing." unless listing_saved
      # Create images attached to listing
      create_images
      # Create location of listing
      location_hash = params[:listing][:location]
      if location_hash
        @location = Location.new
        @location.address = location_hash[:address]
        @location.city = location_hash[:city]
        @location.state = location_hash[:state]
        @location.postcode = location_hash[:postcode]
        @location.listing_id = @listing.id
        @location.save
      end
      redirect_to @listing, notice: 'Listing was successfully created.'
    rescue ListingError, ArgumentError => e
      flash[:alert] = e.message
      render 'new'
    end
  end

  # PATCH/PUT /listings/1
  def update
    begin
      delete_images
      create_images
      # Convert to cents
      updated_params = listing_params
      updated_params[:daily_price] = 100 * updated_params[:daily_price].to_i
      updated_params[:weekly_price] = 100 * updated_params[:weekly_price].to_i

      if @listing.update(updated_params)
        redirect_to @listing, notice: 'Listing was successfully updated.'
      else
        raise ListingError, @listing.errors.full_messages.to_s
      end
    rescue ListingError, ArgumentError => e
      redirect_to edit_listing_path(@listing), alert: e.message
    end
  end

  # DELETE /listings/1
  def destroy
    if @listing.destroy
      redirect_to listings_path, notice: 'Listing was successfully destroyed.'
    else
      redirect_to listing_path(@listing), notice: 'Failed to destroy listing.'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_listing
      @listing = Listing.find(params[:id])
    end

    # Check if current user is allowed to perform action
    def check_permission
      unless @listing.user_id == current_user.id
        redirect_back(fallback_location: listing_path(@listing),
          alert: "Error: Permission denied - Invalid User")
      end
    end

    # Remove images if option is selected on edit page
    def delete_images
      @listing.listing_images.each do |img|
        if params[:listing][:listing_image][:remove_image] == '1'
          img.destroy
        end
      end
    end

    # Create images on new listing and edit
    def create_images
      if params[:listing][:listing_image] && params[:listing][:listing_image][:image]
        params[:listing][:listing_image][:image].each do |img|
          @image = @listing.listing_images.create(image: img)
          raise ListingError, "Couldn't create image. #{img}" unless @image
        end
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def listing_params

      params.require(:listing).permit(:user_id, :title, :description, :category,
                      :item_type, :size, :brand, :bindings, :boots,
                      :helmet, :daily_price, :weekly_price,
                      listing_image_attributes: :image,
                      location_attributes: [:address, :city, :state, :postcode, :country]
                      )
     end
end
