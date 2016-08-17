json.extract! event, :id, :title, :event_type, :begin_at, :end_at, :active_members, :description, :facebook_identifier, :locked, :created_at, :updated_at
json.url event_url(event, format: :json)