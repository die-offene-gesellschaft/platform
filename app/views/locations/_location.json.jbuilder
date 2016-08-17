json.extract! location, :id, :latitude, :longitude, :radius, :created_at, :updated_at
json.url location_url(location, format: :json)