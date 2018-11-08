class Listing < ApplicationRecord
  # Sanitization
  before_save :remove_whitespace, :normalize_attributes

  # Relationships
  belongs_to :user
  has_one :location, dependent: :destroy
  has_many :listing_images, dependent: :destroy
  accepts_nested_attributes_for :listing_images, :location
  has_many :bookings, dependent: :destroy
  has_many :renters, through: :bookings
  has_many :unavailable_days, dependent: :destroy
  enum item_type: [:Freestyle, :All_Mountain, :Freeride, :Powder, :Carving, :Other]
  enum category: [:Snowboard, :Ski]

  # Validation
  validates_associated :location
  validates :title, :category, :item_type, :brand, :size, :daily_price, :weekly_price, presence: { message: "must be given." }
  validates :size, inclusion: { in: 90..200,
    message: "%{value}cm is not within accepted range of 90cm to 200cm" }
  validates :daily_price, :weekly_price, numericality: { greater_than: 0, less_than: 10000000,
    message: "must be greater than $0.00 and less than $100,000.00" }

  protected

  # Make title and brand consistent across all records in database
  def normalize_attributes
    self.title = self.title.downcase.titleize
    self.brand = self.brand.downcase.titleize
  end
end
