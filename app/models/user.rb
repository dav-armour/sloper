class User < ApplicationRecord
  # Sanitization
  before_save :remove_whitespace, :normalize_attributes

  # Devise config
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable

  # Relationships
  has_many :listings
  has_many :bookings

  # Carrierwave config
  mount_uploader :profile_image, AvatarUploader

  # Validation
  validates_format_of :first_name, :last_name, with: /\A[^0-9`!@#\$%\^&*+_=\?\(\)\,\\\/]+\z/
  validates_format_of :phone, with: /\A^\s*(?:\+?(\d{1,3}))?([-. (]*(\d{3})[-. )]*)?((\d{3})[-. ]*(\d{2,4})(?:[-.x ]*(\d+))?)\s*\z/

  # Model scoped methods
  def full_name
    "#{self.first_name} #{self.last_name}".titleize
  end

  protected

  # Make name and email consistent throughout database
  def normalize_attributes
    self.first_name = self.first_name.downcase.titleize
    self.last_name = self.last_name.downcase.titleize
    self.email.downcase!
  end

end
