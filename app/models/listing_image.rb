class ListingImage < ApplicationRecord
  before_destroy :delete_from_aws
  belongs_to :listing
  mount_uploader :image, ImageUploader

  def delete_from_aws
    self.remove_image!
    self.save
  end
end
