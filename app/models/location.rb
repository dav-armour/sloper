class Location < ApplicationRecord
  # Sanitization
  before_save :remove_whitespace, :normalize_attributes

  # Relationships
  belongs_to :listing

  # Validation
  validates :address, :city, :state, :postcode, :country, presence: { message: "must be given." }

  protected

  # Make location details consistent throughout database
  def normalize_attributes
    self.address.downcase!
    self.state.upcase!
    self.city = self.city.downcase.titleize
    self.country = self.country.downcase.titleize
  end
end
