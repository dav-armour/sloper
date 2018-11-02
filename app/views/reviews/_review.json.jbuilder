json.extract! review, :id, :rating, :content, :booking_id, :created_at, :updated_at
json.url review_url(review, format: :json)
