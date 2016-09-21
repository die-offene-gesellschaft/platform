class HomeController < ApplicationController
  def show
    @events = Event.all
    @users = User.all
    @blogposts = Blogpost.all
  end
end
