class SessionsController < Devise::SessionsController
  before_action :before_login,
                only: :create

  def before_login
    sign_out current_admin if current_admin
    sign_out current_user if current_user
  end
end
