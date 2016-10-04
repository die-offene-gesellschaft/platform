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
    if @user.save
      flash.now[:success] = t('participate.success')
      create_task_variable @user
    else
      flash.now[:error] = t('participate.error',
                            error_description: @user.errors.full_messages.to_sentence)
    end
    render :show
  end

  private

  def set_user
    @user = User.new
  end

  def set_users
    @users = User.where(locked: false)
                 .where.not(avatar_file_name: nil)
                 .sample(18)
  end

  def set_contents
    @contents = {}
    [:what_next, :support, :diy].each do |key|
      @contents[key] = get_content_for_key key
    end
  end

  def get_content_for_key(key)
    Content.where(controller_action_name: "#{controller_name}#show")
           .where(key: key)
           .limit(1)
           .first
  end

  def create_task_variable(created_user)
    @task = :member if created_user.terms_of_use
    @task = :newsletter unless created_user.terms_of_use
  end

  def process_contents
    @contents.each do |_, content|
      html = Kramdown::Document.new(content.value).to_html
      content.value = html
    end
  end

  def user_params
    u_params = general_user_params
    u_params[:newsletter] = true if participate_params[:newsletter]
    if participate_params[:terms_of_use]
      u_params[:terms_of_use] = true
    else
      u_params[:password] = SecureRandom.hex
      u_params[:password_confirmation] = u_params[:password]
    end
    u_params
  end

  def general_user_params
    {
      forename: participate_params[:forename],
      surname: participate_params[:surname],
      email: participate_params[:email],
      password: participate_params[:password],
      password_confirmation: participate_params[:password_confirmation],
      avatar: participate_params[:avatar],
      role: participate_params[:role],
      statement: participate_params[:statement],
      locked: true
    }
  end

  def participate_params
    params.require(:user).permit(
      :forename, :surname, :email,
      :newsletter,
      :terms_of_use,
      :avatar,
      :password,
      :password_confirmation,
      :role,
      :statement
    )
  end
end
