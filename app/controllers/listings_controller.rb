class ListingsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_listing, only: [:show, :edit, :update, :destroy]
  before_action :check_permissions, only: [:edit, :update, :destroy]

  # GET /listings
  def index
    @listings = Listing.includes(:location, :listing_images)
    unless params[:city].blank?
      @listings = @listings.references(:locations).fuzzy_search({locations: { city: "#{params[:city]}"}})
      @listings = [] if @listings.blank?
    end
    unless params[:category].blank? || params[:category] == "All"
      @listings = @listings.where(category: "#{params[:category]}")
    end
    unless params[:item_type].blank? || params[:item_type] == "All"
      @listings = @listings.where(item_type: "#{params[:item_type]}")
    end
    unless params[:brand].blank?
      @listings = @listings.fuzzy_search(brand: "#{params[:brand]}")
    end
    unless params[:start_date].blank? || params[:end_date].blank?
      if params[:start_date].to_date < Time.now.to_date
        @listings = []
      else
        date_arr = (params[:start_date].to_date..params[:end_date].to_date).to_a
        unavailable_list_ids = UnavailableDay.select(:listing_id).where(day: date_arr)
        @listings = @listings.where.not(id: unavailable_list_ids)
      end
    end
    params[:results_per_page] ||= '10'
    @listings = @listings.limit(params[:results_per_page])
  end

  # GET /listings/1
  def show
    @user = User.find(@listing.user_id)
    @reviews = Review.includes(:booking, booking: :user).where(bookings: {listing_id: @listing.id})
    @average_rating = @reviews.average(:rating)
    # @average_rating = @reviews.average(:rating).round unless @reviews.empty?
  end

  # GET /listings/new
  def new
    @listing = Listing.new
    @listing.location ||= Location.new
  end

  # GET /listings/1/edit
  def edit
    @listing.daily_price /= 100
    @listing.weekly_price /= 100
  end

  # POST /listings
  def create
    begin
      @listing = Listing.new(listing_params)
      # Convert dollars to cents
      @listing.daily_price *= 100
      @listing.weekly_price *= 100
      @listing.user_id = current_user.id
      raise ListingError, @listing.errors.full_messages.first unless @listing.valid?
      listing_saved = @listing.save
      raise ListingError, "Couldn't save listing." unless listing_saved
      create_images
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
    rescue ListingError => e
      redirect_to new_listing_path(@listing), alert: e.message
    end
  end

  # PATCH/PUT /listings/1
  def update
    begin
      @listing.listing_images.each do |img|
        if params[:listing][:listing_image][:remove_image] == '1'
          img.destroy
        end
      end
      create_images
      # Convert to cents
      updated_params = listing_params
      updated_params[:daily_price] = 100 * updated_params[:daily_price].to_i
      updated_params[:weekly_price] = 100 * updated_params[:weekly_price].to_i

      if @listing.update(updated_params)
        redirect_to @listing, notice: 'Listing was successfully updated.'
      else
        render :edit
      end
    rescue ListingError => e
      redirect_to new_listing_path(@listing), alert: e.message
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

    def check_permissions
      redirect_back(fallback_location: listing_path(@listing)) unless @listing.user_id == current_user.id
    end

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
                      location_attributes: [:address, :city, :state, :postcode]
                      )
     end
end
