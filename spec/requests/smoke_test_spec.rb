require 'rails_helper'

RSpec.describe "GET routes", type: :request do
  before(:each) do
    `rails db:seed_fu FILTER=contents`
    @event = FactoryGirl.create :event,
                                begin_at: 1.day.from_now,
                                end_at: 2.days.from_now,
                                planned: false
    @user = @event.user
    @video_user = FactoryGirl.create :video_user
    @vip_user = FactoryGirl.create :vip_user
    @frontpage_user = FactoryGirl.create :frontpage_user
    @admin = FactoryGirl.create :admin
    @venue = @event.venue
    @comment = FactoryGirl.create :comment,
                                  user: @user,
                                  event: @event
    @picture = FactoryGirl.create :picture,
                                  user: @user,
                                  event: @event
    @blogposts = [
                   FactoryGirl.create(:blogpost, title: 'first post'),
                   FactoryGirl.create(:blogpost, title: 'second minor interesting post')
                 ]
    @content = FactoryGirl.create :content
    @press_review = FactoryGirl.create :press_review
    @idea = FactoryGirl.create :idea
    @statement = FactoryGirl.create :statement
    @organizer = FactoryGirl.create :organizer
    FactoryGirl.create(:user, email: 'jane.doe@example.com', password: '12345678')
    @slide = FactoryGirl.create :slide
  end

  it 'should be error-free' do
    routes = ROUTES.select { |r| r[:method] == 'GET' }
    routes.each do |route|
      path = route[:path]
      new_path = path.gsub(/\/:slug/, '/first-post')
      get new_path
      expect([200, 301, 302]).to include(response.status)
    end
  end

  ROUTES = Rails.application.routes.routes.map do |route|
    path = route.path.spec.to_s.gsub(/\(\.:format\)/, '').gsub(/:([a-zA-Z]+_){0,1}id/, '1')
    method = %W{ GET POST PUT PATCH DELETE }.grep(route.verb).first
    { path: path, method: method }
  end
end
