# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: User::USER_PERMIT)
  end

  def after_sign_up_path_for _resource
    new_user_session_path
  end
end
