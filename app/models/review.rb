class Review < ApplicationRecord
  # Relationships
  belongs_to :booking
  has_one :user, through: :booking

  # Validation
  validates :rating, inclusion: { in: 1..5,
    message: "%{value} is not within range 1 to 5" }
  validates :content, presence: true
end
