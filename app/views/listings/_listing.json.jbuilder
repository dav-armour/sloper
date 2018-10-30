json.extract! listing, :id, :user_id, :title, :description, :category, :type, :size, :brand, :bindings, :boots, :helmet, :daily_price, :weekly_price, :created_at, :updated_at
json.url listing_url(listing, format: :json)
