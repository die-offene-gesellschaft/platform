class HomeController < ApplicationController
  def show
    @events = Event.all
    @users = User.where('id > 1')
    @blogposts = Blogpost.all
  end
end
