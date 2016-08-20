require 'rails_helper'

RSpec.describe "Locations", type: :request do
  describe "GET /de/locations" do
    it "works! (now write some real specs)" do
      get locations_path locale: :de
      expect([200, 301, 302]).to include(response.status)
    end
  end
end
