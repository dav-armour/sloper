class ListingsController < ApplicationController
  before_action :set_listing, :set_location, only: [:show, :edit, :update, :destroy]
  before_action :check_permissions, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  # GET /listings
  # GET /listings.json
  def index
    # @listings = Listing.all
    if params[:city]
      @listings = Listing.includes(:location, :listing_images).references(:locations).fuzzy_search({locations: { city: "#{params[:city]}"}})
    else
      @listings = Listing.includes(:location, :listing_images)
    end
  end

  # GET /listings/1
  # GET /listings/1.json
  def show
    @user = User.find(@listing.user_id)
  end

  # GET /listings/new
  def new
    @listing = Listing.new
  end

  # GET /listings/1/edit
  def edit
  end

  # POST /listings
  # POST /listings.json
  def create
    begin
      @listing = Listing.new(listing_params)
      @listing.user_id = current_user.id
      listing_saved = @listing.save
      raise "Couldn't save listing." unless listing_saved
      if params[:listing][:listing_image]
        params[:listing][:listing_image][:image].each do |img|
          @image = @listing.listing_images.create(image: img)
          raise "Couldn't create image. #{img}" unless @image
        end
      end
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
    rescue StandardError => e
      redirect_to new_listing_path(@listing), alert: e.message
    end
  end

  # PATCH/PUT /listings/1
  # PATCH/PUT /listings/1.json
  def update
    respond_to do |format|
      if @listing.update(listing_params)
        format.html { redirect_to @listing, notice: 'Listing was successfully updated.' }
        format.json { render :show, status: :ok, location: @listing }
      else
        format.html { render :edit }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /listings/1
  # DELETE /listings/1.json
  def destroy
    @listing.destroy
    respond_to do |format|
      format.html { redirect_to listings_url, notice: 'Listing was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_listing
      @listing = Listing.find(params[:id])
    end

    def set_location
      @location = Location.all
    end

    def check_permissions
      redirect_back(fallback_location: listing_path(@listing)) unless @listing.user_id == current_user.id
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
