class AddCountryToLocation < ActiveRecord::Migration[5.2]
  def change
    add_column :locations, :country, :string
  end
end
