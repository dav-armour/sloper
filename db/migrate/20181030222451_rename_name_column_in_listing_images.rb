class RenameNameColumnInListingImages < ActiveRecord::Migration[5.2]
  def change
    rename_column :listing_images, :name, :image
  end
end
