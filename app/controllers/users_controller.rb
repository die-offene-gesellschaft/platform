class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  # GET /users
  def index
    @users = User.where(locked: false)
    @active_members = ActiveMember.all if request.query_parameters.keys.include?('list')
  end

  def show
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
