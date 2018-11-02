class ChangeImagesToListingImages < ActiveRecord::Migration[5.2]
  def change
    rename_table :images, :listing_images
  end
end
