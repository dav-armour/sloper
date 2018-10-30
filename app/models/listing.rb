class Listing < ApplicationRecord
  belongs_to :user
  belongs_to :location
  has_many :images
  has_many :bookings
  has_many :renters, through: :bookings
  has_many :available_days
  enum item_type: [:Freestyle, :All_Mountain, :Freeride, :Powder, :Carving, :Other]
  enum category: [:Snowboard, :Ski]
end
