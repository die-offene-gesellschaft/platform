json.extract! venue,
              :id, :name, :street, :zip_code, :city, :description, :locked,
              :created_at, :updated_at
json.url venue_url(venue, format: :json)
