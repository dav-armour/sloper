class Location < ApplicationRecord
  before_save :remove_whitespace
  belongs_to :listing

  def remove_whitespace
    attribute_names.each do |name|
      if send(name).respond_to?(:strip)
        send("#{name}=", send(name).strip)
      end
    end
  end 
end
