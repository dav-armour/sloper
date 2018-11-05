class Listing < ApplicationRecord
  before_save :remove_whitespace
  belongs_to :user
  has_one :location, dependent: :destroy
  has_many :listing_images, dependent: :destroy
  accepts_nested_attributes_for :listing_images, :location
  has_many :bookings, dependent: :destroy
  has_many :renters, through: :bookings
  has_many :unavailable_days, dependent: :destroy
  enum item_type: [:Freestyle, :All_Mountain, :Freeride, :Powder, :Carving, :Other]
  enum category: [:Snowboard, :Ski]
  # validates_associated :location
  validates :title, :category, :item_type, :brand, :size, :daily_price, :weekly_price, presence: { message: "must be given." }
  validates :size, inclusion: { in: 90..220,
    message: "%{value} cms is not within range 90 cms to 220 cms" }
  validates :daily_price, :weekly_price, numericality: { greater_than: 0 }
end
