class Listing < ApplicationRecord
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
  validates :size, numericality: { greater_than_or_equal_to: 90, less_than_or_equal_to: 220 }
  validates :daily_price, :weekly_price, numericality: { greater_than: 0 }
end
