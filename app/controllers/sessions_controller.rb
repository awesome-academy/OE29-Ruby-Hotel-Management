class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user&.authenticate(params[:session][:password])
      activate_check user
    else
      flash[:danger] = t "global.log_in_false"
      redirect_to root_url
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private

  def activate_check user
    if user.activated?
      log_in user
      remember = params[:session][:remember_me]
      remember == "1" ? remember(user) : forget(user)
      if user.admin?
        redirect_to admin_root_path
      else
        redirect_to user
      end
    else
      flash[:warning] = t "global.message"
      redirect_to root_url
    end
  end
end
