class Listing < ApplicationRecord
  after_create_commit :add_available_days

  belongs_to :user
  has_one :location, dependent: :destroy
  has_many :listing_images, dependent: :destroy
  accepts_nested_attributes_for :listing_images, :location
  has_many :bookings, dependent: :destroy
  has_many :renters, through: :bookings
  has_many :available_days, dependent: :destroy
  enum item_type: [:Freestyle, :All_Mountain, :Freeride, :Powder, :Carving, :Other]
  enum category: [:Snowboard, :Ski]
  # validates_associated :location
  validates :title, :category, :item_type, :size, :brand, 
            :daily_price, :weekly_price, presence: { message: "must be given." }



  # Adds 6 months of available days when model is created
  def add_available_days
    puts "Adding available days"
    date = Date.today
    180.times do
      AvailableDay.create(
        day: date,
        listing_id: self.id
      )
      date += 1
    end
    puts "Finished adding days."
  end
end
