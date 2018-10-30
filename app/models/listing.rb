class Listing < ApplicationRecord
  belongs_to :user
  has_one :location, dependent: :destroy
  has_many :images, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many :renters, through: :bookings
  has_many :available_days, dependent: :destroy
  enum item_type: [:Freestyle, :All_Mountain, :Freeride, :Powder, :Carving, :Other]
  enum category: [:Snowboard, :Ski]
end
