class Location < ApplicationRecord
  before_save :remove_whitespace
  belongs_to :listing
end
