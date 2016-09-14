class UsersController < ApplicationController
  before_action :set_users, only: [:index]
  before_action :set_user, only: [:show]

  # GET /users
  def index
    respond_to do |format|
      format.html do
        if request.query_parameters.keys & %w(pictures list) == []
          return redirect_to(users_path(pictures: ''))
        end
        render :index
      end
      format.json do
        return render json: {
                        active_members: @active_members,
                        users: @users
                      } if @active_members
        render json: @users
      end
    end
  end

  def show
    respond_to do |format|
      format.html { render :show }
      format.json { render json: @user }
    end
  end

  private

  def set_users
    if request.query_parameters.keys.include?('pictures')
      @users = User.where(locked: false)
    elsif request.query_parameters.keys.include?('list')
      @users = User.where(locked: false)
      @active_members = ActiveMember.all if request.query_parameters.keys.include?('list')
    else
      @users = User.all
    end
  end

  def set_user
    @user = User.find(params[:id])
  end
end
