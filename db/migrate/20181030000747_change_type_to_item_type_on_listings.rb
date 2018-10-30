class ChangeTypeToItemTypeOnListings < ActiveRecord::Migration[5.2]
  def change
    rename_column :listings, :type, :item_type
  end
end
