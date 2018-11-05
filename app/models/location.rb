class Location < ApplicationRecord
  before_save :remove_whitespace
  belongs_to :listing
  validates :address, :city, :state, :postcode, presence: { message: "must be given." }
end
