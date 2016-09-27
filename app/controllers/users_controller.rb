class UsersController < ApplicationController
  before_action :set_users, only: [:index]
  before_action :set_user, only: [:show, :destroy]

  # GET /users
  def index
    respond_to do |format|
      format.html do
        if request.query_parameters.keys & %w(pictures list) == []
          return redirect_to(users_path(pictures: ''))
        end
        render :index
      end
      format.json { index_json }
    end
  end

  def show
    respond_to do |format|
      format.html { render :show }
      format.json { render json: @user }
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

    get_params = request.query_parameters.keys
    if get_params.include?('pictures')
      set_statements
      @users = @users.where.not(avatar_file_name: nil)
    elsif get_params.include?('list')
      @active_members = ActiveMember.all
    end
  end

  def set_statements
    @statement_users = @users.where(avatar_file_name: nil)
                             .where.not(statement: nil)
                             .limit(3)

    if @statement_users.count < 3
      @statement_users = @users.where.not(statement: nil)
                               .limit(3)
    end
  end

  def set_user
    @user = User.find(params[:id])
  end

  def index_json
    return render json: { active_members: @active_members,
                          users: @users } if @active_members
    render json: @users
  end
end
