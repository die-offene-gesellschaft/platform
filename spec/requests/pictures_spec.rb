require 'rails_helper'

RSpec.describe "Pictures", type: :request do
  describe "GET /de/pictures" do
    it "works! (now write some real specs)" do
      get pictures_path(locale: :de)
      expect([200, 301, 302]).to include(response.status)
    end
  end
end
