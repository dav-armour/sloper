class ListingImage < ApplicationRecord
  # Model scoped methods
  before_destroy :delete_from_aws

  # Relationships
  belongs_to :listing

  # Carrierwave config
  mount_uploader :image, ImageUploader

  protected

  # Needed to delete image from AWS S3 bucket
  def delete_from_aws
    self.remove_image!
    self.save
  end
end
