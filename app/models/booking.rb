class Booking < ApplicationRecord
  # Model scoped methods
  after_create_commit :add_unavailable_days
  before_destroy :remove_unavailable_days

  # Relationships
  belongs_to :user
  belongs_to :listing
  has_one :review, dependent: :destroy

  protected

  # Add each booked day to unavailable days on creation
  def add_unavailable_days
    date_arr = (self.start_date..self.end_date).to_a
    date_arr.each do |date|
      UnavailableDay.create(
        day: date,
        listing_id: self.listing_id
      )
    end
  end

  # Remove booked days from unavailable days when a booking is cancelled/refunded
  def remove_unavailable_days
    date_arr = (self.start_date..self.end_date).to_a
    UnavailableDay.where(listing_id: self.listing_id, day: date_arr).destroy_all
  end
end
