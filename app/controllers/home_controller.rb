class HomeController < ApplicationController
  def show
    @events = Event.all
    @users = User.where(locked: false).where.not(avatar_file_name: nil)
    @blogposts = Blogpost.all
  end
end
