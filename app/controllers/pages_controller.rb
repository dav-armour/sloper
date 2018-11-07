class PagesController < ApplicationController
  def landing
  end

  def profile
    @user = User.find(params[:user_id])
    # Eager load images attached to each listing. Join location to show city. Only show listing's of current profile's user
    @listings = Listing.includes(:listing_images).joins(:location).select("listings.*, locations.city, locations.country").where(user_id: params[:user_id])
    # Get just the listing id's to be used in review query
    listing_ids = @listings.pluck(:id)
    @total_listings = listing_ids.count
    # Eager load booking to get only reviews related to current listing. Eager load user to show author of review
    @reviews = Review.includes(:booking, booking: :user).where(bookings: {listing_id: listing_ids})
    @total_reviews = @reviews.size
    @average_rating = @reviews.average(:rating)
    @last_sign_in = @user.last_sign_in_at
  end
end
