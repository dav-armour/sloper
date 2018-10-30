class CreateListings < ActiveRecord::Migration[5.2]
  def change
    create_table :listings do |t|
      t.references :user, foreign_key: true
      t.string :title
      t.text :description
      t.integer :category
      t.integer :type
      t.integer :size
      t.string :brand
      t.boolean :bindings
      t.boolean :boots
      t.boolean :helmet
      t.integer :daily_price
      t.integer :weekly_price

      t.timestamps
    end
  end
end
