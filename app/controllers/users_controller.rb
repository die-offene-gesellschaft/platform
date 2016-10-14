class UsersController < ApplicationController
  before_action :authenticate_admin!, only: [:edit, :update]

  before_action :set_users, only: [:index]
  before_action :set_admin_users, only: [:index]
  before_action :set_user, only: [:show, :destroy, :edit, :update]

  # GET /users
  def index
    respond_to do |format|
      format.html { render :index }
      format.json { render json: @users }
    end
  end

  def show
    respond_to do |format|
      format.html { render :show }
      format.json { render json: @user }
    end
  end

  def edit
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to users_path, notice: t('actions.save.success') }
        format.json { render :show, status: :ok, location: @user }
      else
        flash.now[:error] = t('actions.save.error')
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authenticate_admin! unless user_signed_in?
    if admin_signed_in?
      @user.destroy
      redirect_to users_path
    else
      current_user.destroy
      flash[:success] = t('users.success.delete-profile')
      redirect_to home_path
    end
  end

  private

  def set_users
    @users = User.where(locked: false)
                 .order(created_at: :desc)

    get_params = request.query_parameters.keys
    authenticate_admin! if get_params & %w(pictures list) == []
    filter_user_from get_params
  end

  def filter_user_from(get_params)
    if get_params.include?('pictures')
      filter_user_for_pictures_param
    elsif get_params.include?('list')
      @active_members = ActiveMember.all
    end
  end

  # this method smells of :reek:DuplicateMethodCall
  def filter_user_for_pictures_param
    @video_users = @users.where.not(video_url: [nil, ''])
                         .where.not(avatar_file_name: nil)
    @statement_users = @users.where.not(statement: [nil, ''])
                             .where(video_url: [nil, ''])
                             .where.not(id: @video_users.map(&:id))
                             .sample(10)
    @users = @users.where.not(avatar_file_name: nil)
                   .where(video_url: [nil, ''])
                   .where.not(id: @statement_users.map(&:id))
  end

  def set_admin_users
    newsletter_only_ids = User.where(newsletter: true, terms_of_use: false)
                              .map(&:id)
    @admin_users = User.where.not(id: newsletter_only_ids)
                       .order(created_at: :desc)
    set_filters
    apply_filters
  end

  def set_filters
    @filters = {}
    request.query_parameters.each do |key, value|
      @filters[key] = value if key =~ /^filter-/
    end
  end

  def apply_filters
    @admin_users = User.apply_filters(@admin_users, params)
  end

  def set_user
    @user = User.find(params[:id])
    authenticate_admin! if @user.locked
  end

  def user_params
    params.require(:user).permit(
      :locked,
      :role,
      :statement,
      :video_url,
      :vip,
      :good_photo,
      :good_statement,
      :contributor
    )
  end
end
