class PagesController < ApplicationController
  def landing
  end

  def profile
    @user = User.includes(:listings, listings: :listing_images).find(params[:user_id])
    listing_ids = @user.listings.pluck(:id)
    @reviews = Review.includes(:booking, booking: :user).where(bookings: {listing_id: listing_ids})
    @average_rating = @reviews.average(:rating)
  end
end
