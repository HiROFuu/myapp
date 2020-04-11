json.extract! post, :id, :user_id, :description, :image, :created_at, :updated_at
json.url post_url(post, format: :json)
