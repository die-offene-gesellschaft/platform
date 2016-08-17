class UsersController < ApplicationController
  # GET /users
  def index
    @users = User.where(locked: false)
  end
end
