class ApplicationController < ActionController::Base
  rescue_from ActionController::RoutingError, with: :render_404

  before_action :set_locale
  include SessionsHelper

  def render_404
    render file: Rails.root.join("public", "404.html").to_s, layout: false,
           status: :not_found
  end


  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = t "global.please_login"
    redirect_to login_url
  end

  def user_params
    params.required(:user).permit User::USER_PERMIT
  end

  def find_user
    @user = User.find id: params[:id]
    return if @user

    flash[:danger] = t "global.not_found_user"
    redirect_to root_path
  end

  def correct_user
    redirect_to root_url unless current_user? @user
  end
end
