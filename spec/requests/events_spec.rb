require 'rails_helper'

RSpec.describe "Events", type: :request do
  describe "GET /de/events" do
    it "works! (now write some real specs)" do
      get events_path locale: :de
      expect([200, 301, 302]).to include(response.status)
    end
  end
end
