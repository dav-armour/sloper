class AddStripeCustIdToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :stripe_cust_id, :text
  end
end
