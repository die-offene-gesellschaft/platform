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
    return render 'user_edit' if user_signed_in?
    render 'admin_edit' if admin_signed_in?
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
  def update
    return unless update_permitted?

    if user_signed_in? && @user.update_with_password(params_with_locked_check)
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
    return unless update_permitted?
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
    return unless update_permitted?
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

  def params_with_locked_check
    # This should be model logic.
    # It currently isn't because of admins beeing able to change details.
    # Adopt this code as soon as admins just set 'locked' to true / false.
    new_params = user_params
    new_params[:locked] = @user.role != user_params[:role] ||
                          @user.statement != user_params[:statement] ||
                          @user.video_url != user_params[:video_url] ||
                          user_params[:avatar_file_name]
    new_params
  end

  def set_user
    @user = User.find_by(id: params[:id])
    @user = User.find_by(id: params[:user_id]) unless @user
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

  def filter_user_for_pictures_param
    @video_users, @statement_users, @picture_users, @users = User.filter_for_pictures(@users)
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

  # rubocop:disable Metrics/MethodLength
  def user_params
    tmp_params = params.require(:user).permit(
      :avatar, :contributor, :current_password, :email, :forename, :frontpage, :good_photo,
      :good_statement, :locked, :newsletter, :password_confirmation, :password, :role, :statement,
      :surname, :terms_of_use, :video_url, :vip
    )
    tmp_params[:newsletter] = tmp_params[:newsletter] == 'on'
    tmp_params
  end
end
