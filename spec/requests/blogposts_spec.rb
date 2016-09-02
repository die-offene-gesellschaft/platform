require 'rails_helper'

RSpec.describe "Blogposts", type: :request do
  describe "GET /blogposts" do
    it "works! (now write some real specs)" do
      get blogposts_path
      expect(response).to have_http_status(200)
    end
  end
end
