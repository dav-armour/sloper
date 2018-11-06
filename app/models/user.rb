class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  before_save :remove_whitespace
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :listings
  has_many :bookings
  mount_uploader :profile_image, AvatarUploader

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  validates_format_of :first_name, :last_name, with: /\A[^0-9`!@#\$%\^&*+_=\?\(\)\,\\\/]+\z/
  validates_format_of :phone, with: /\A^\s*(?:\+?(\d{1,3}))?([-. (]*(\d{3})[-. )]*)?((\d{3})[-. ]*(\d{2,4})(?:[-.x ]*(\d+))?)\s*\z/
end
