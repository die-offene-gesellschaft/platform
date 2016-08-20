require 'rails_helper'

RSpec.describe "Comments", type: :request do
  describe "GET /de/comments" do
    it "works! (now write some real specs)" do
      get comments_path
      expect([200, 301, 302]).to include(response.status)
    end
  end
end
