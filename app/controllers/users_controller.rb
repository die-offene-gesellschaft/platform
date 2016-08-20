class UsersController < ApplicationController
  before_action :set_user

  # GET /users
  def index
    @users = User.where(locked: false)
  end

  private

  def set_user
    @user = current_user
  end
end
