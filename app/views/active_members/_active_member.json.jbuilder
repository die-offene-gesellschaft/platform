json.extract! active_member, :id, :forename, :surname, :role, :created_at, :updated_at
json.url active_member_url(active_member, format: :json)
