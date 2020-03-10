json.extract! event, :id, :title, :event_data, :event_place, :event_style, :body, :created_at, :updated_at
json.url event_url(event, format: :json)
