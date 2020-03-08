json.extract! event, :id, :title, :eventdate, :eventplace, :eventstyle, :body, :created_at, :updated_at
json.url event_url(event, format: :json)
