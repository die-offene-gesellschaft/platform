require 'rails_helper'

RSpec.describe "GET routes", type: :request do
  before(:each) do
    %w(user comment picture event location venue).each do |model|
      FactoryGirl.create(model)
    end
  end

  it 'should be error-free' do
    routes = ROUTES.select { |r| r[:method] == 'GET' }
    routes.each do |route|
      path = route[:path]
      path.gsub!(/:role/, 'bootstrap')
      get path
      expect([200, 301, 302]).to include(response.status)
    end
  end

  ROUTES = Rails.application.routes.routes.map do |route|
    path = route.path.spec.to_s.gsub(/\(\.:format\)/, '').gsub(/:([a-zA-Z]+_){0,1}id/, '1')
    method = %W{ GET POST PUT PATCH DELETE }.grep(route.verb).first
    { path: path, method: method }
  end
end
