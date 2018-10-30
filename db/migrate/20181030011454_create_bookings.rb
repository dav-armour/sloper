class CreateBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :bookings do |t|
      t.references :user, foreign_key: true
      t.references :listing, foreign_key: true
      t.date :start_date
      t.date :end_date
      t.date :booking_date
      t.integer :total_cost
      t.text :stripe_charge_id

      t.timestamps
    end
  end
end
