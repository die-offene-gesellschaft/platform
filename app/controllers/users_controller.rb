class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  # GET /users
  def index
    @users = User.where(locked: false)
  end

  def show
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
