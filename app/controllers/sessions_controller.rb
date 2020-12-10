class SessionsController < Devise::SessionsController
  before_action :authenticate_user!

  protected

  def after_sign_in_path_for
    user_path
  end

  def after_sign_out_path_for
    new_user_session_path
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
