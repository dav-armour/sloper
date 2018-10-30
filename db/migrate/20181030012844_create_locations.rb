class CreateLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :locations do |t|
      t.string :city
      t.integer :postcode
      t.string :address
      t.references :listing, foreign_key: true

      t.timestamps
    end
  end
end
