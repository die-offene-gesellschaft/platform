class ParticipateController < ApplicationController
  before_action :set_user, only: [:show, :create]
  before_action :set_users, only: [:show, :create]

  # GET /participate
  def show
  end

  # POST /participate
  def create
    @user = User.new(user_params)
    register_newsletter if participate_params[:newsletter]
    register_platform if participate_params[:terms_of_use]
    handle_flash
    render :show
  end

  private

  def set_user
    @user = User.new
  end

  def set_users
    @users = User.where(locked: false).where.not(avatar_file_name: nil).sample(15)
  end

  def participate_params
    params.require(:participate).permit(
      :name, :email,
      :newsletter,
      :terms_of_use,
      :avatar,
      :password,
      :password_repeat,
      :role,
      :statement
    )
  end

  def register_newsletter
    @newsletter = Newsletter.new(newsletter_params)
    flash.now[:error] = t('participate.error') unless @newsletter.save
  end

  def newsletter_params
    {
      name: participate_params[:name],
      email: participate_params[:email]
    }
  end

  def user_params
    {
      name: participate_params[:name],
      email: participate_params[:email],
      password: participate_params[:password],
      avatar: participate_params[:avatar],
      role: participate_params[:role],
      statement: participate_params[:statement],
      locked: true
    }
  end

  def register_platform
    @terms_of_use = true
    flash.now[:error] = t('participate.error') unless @user.save
  end

  def handle_flash
    if !flash.now[:error] && (participate_params[:newsletter] || participate_params[:terms_of_use])
      flash.now[:success] = t('participate.success')
    end
  end
end
