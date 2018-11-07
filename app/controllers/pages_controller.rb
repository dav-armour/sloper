class PagesController < ApplicationController
  def landing
  end

  def profile
    @user = User.find(params[:user_id])
    @listings = Listing.includes(:listing_images).joins(:location).select("listings.*, locations.city, locations.country").where(user_id: params[:user_id])
    listing_ids = @listings.pluck(:id)
    @total_listings = listing_ids.count
    @reviews = Review.includes(:booking, booking: :user).where(bookings: {listing_id: listing_ids})
    @total_reviews = @reviews.count
    @average_rating = @reviews.average(:rating)
    @last_sign_in = @user.last_sign_in_at
  end
end
