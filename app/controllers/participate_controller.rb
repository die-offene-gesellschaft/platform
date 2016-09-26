class ParticipateController < ApplicationController
  before_action :set_user, only: [:show, :create]
  before_action :set_users, only: [:show, :create]
  before_action :set_contents, only: [:show, :create]
  before_action :process_contents, only: [:show, :create]

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
    @users = User.where(locked: false).where.not(avatar_file_name: nil).sample(18)
  end

  def participate_params
    params.require(:participate).permit(
      :forename, :surname, :email,
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
      forename: participate_params[:forename],
      surname: participate_params[:surname],
      email: participate_params[:email]
    }
  end

  def user_params
    {
      forename: participate_params[:forename],
      surname: participate_params[:surname],
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
    if @user.save
      UserWelcomeMailer.user_welcome_email(@user).deliver_later
    else
      flash.now[:error] = t('participate.error')
    end
  end

  def handle_flash
    if !flash.now[:error] && (participate_params[:newsletter] || participate_params[:terms_of_use])
      flash.now[:success] = t('participate.success')
    end
  end

  def set_contents
    @contents = Content.where(controller_action_name: "#{controller_name}#show")
                       .order(:order)
  end

  def process_contents
    @contents.each do |content|
      html = Kramdown::Document.new(content.value).to_html
      content.value = html
    end
    @content = ''
    @content = @contents.first.value if @contents.any?
  end
end