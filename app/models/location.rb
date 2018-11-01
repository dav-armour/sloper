class Location < ApplicationRecord
  belongs_to :listing

  def self.find_city_like(city)
    fuzzy_search(city: "#{city}")
  end
end
