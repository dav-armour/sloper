class CreateUnavailableDays < ActiveRecord::Migration[5.2]
  def change
    create_table :unavailable_days do |t|
      t.references :listing, foreign_key: true
      t.date :day

      t.timestamps
    end
  end
end
