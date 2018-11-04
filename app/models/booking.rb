class Booking < ApplicationRecord
  before_destroy :add_available_days

  belongs_to :user
  belongs_to :listing
  has_one :review, dependent: :destroy

  def add_available_days
    date_arr = (self.start_date..self.end_date).to_a
    date_arr.each do |date|
      AvailableDay.create(
        day: date,
        listing_id: self.listing_id
      )
    end
  end
end
