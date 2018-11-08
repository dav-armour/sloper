class Location < ApplicationRecord
  before_save :remove_whitespace, :normalize_attributes
  belongs_to :listing
  validates :address, :city, :state, :postcode, :country, presence: { message: "must be given." }

  def normalize_attributes
    self.address.downcase!
    self.state.upcase!
    self.city = self.city.downcase.titleize
    self.country = self.country.downcase.titleize
  end
end
