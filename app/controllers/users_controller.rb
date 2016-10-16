class UsersController < ApplicationController
  before_action :authenticate_any, only: [:edit, :update]

  before_action :set_users, only: [:index]
  before_action :set_admin_users, only: [:index]
  before_action :set_user, only: [:show, :destroy, :edit, :update, :delete_avatar]

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
    return render 'admin_edit' if admin_signed_in?
    render 'user_edit' if user_signed_in?
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/CyclomaticComplexity
  # rubocop:disable Metrics/PerceivedComplexity
  def update
    return unless update_permitted?

    if user_signed_in? && @user.update_with_password(user_params)
      flash.now[:notice] = t('actions.save.success')
      sign_in @user, bypass: true
    elsif admin_signed_in? && @user.update(user_params)
      flash.now[:notice] = t('actions.save.success')
    else
      flash.now[:error] = t('users.user-form.error-notice',
                            error_description: @user.errors.full_messages.to_sentence)
    end

    render 'admin_edit' if admin_signed_in?
    render 'user_edit' if user_signed_in?
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

  def delete_avatar
    @user.avatar = nil
    @user.save!
    redirect_to edit_user_path(@user), notice: t('users.user-form.image.delete-notice')
  end

  private

  def authenticate_any
    return true if admin_signed_in?
    authenticate_user! unless user_signed_in?
  end

  def update_permitted?
    admin_signed_in? || (current_user && @user == current_user)
  end

  def set_user
    @user = User.find_by(id: params[:id])
    @user = User.find_by(id: params[:user_id]) unless @user
    authenticate_admin! if @user.locked
  end

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
    @admin_users = User.where('id NOT IN (?)', newsletter_only_ids)
                       .order(created_at: :desc)
  end

  def user_params
    params.require(:user).permit(
      :avatar,
      :email,
      :forename,
      :locked,
      :newsletter,
      :current_password,
      :password_confirmation,
      :password,
      :role,
      :statement,
      :surname,
      :terms_of_use,
      :video_url
    )
  end
end
