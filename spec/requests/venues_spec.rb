require 'rails_helper'

RSpec.describe "Venues", type: :request do
  describe "GET /de/venues" do
    it "works! (now write some real specs)" do
      get venues_path locale: :de
      expect([200, 301, 302]).to include(response.status)
    end
  end
end
