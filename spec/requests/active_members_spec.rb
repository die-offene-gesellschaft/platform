require 'rails_helper'

RSpec.describe "ActiveMembers", type: :request do
  describe "GET /active_members" do
    it "works! (now write some real specs)" do
      get active_members_path
      expect(response).to have_http_status(200)
    end
  end
end
