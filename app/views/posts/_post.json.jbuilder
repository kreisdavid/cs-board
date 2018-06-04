json.extract! post, :id, :title, :description, :expire_date, :expire_time, :offer_type, :created_at, :updated_at
json.url post_url(post, format: :json)