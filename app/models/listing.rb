class Listing < ApplicationRecord
  belongs_to :user
  belongs_to :location
  has_many :images
  has_many :bookings
  has_many :renters, through: :bookings
  has_many :available_days
end
