# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params

  protected

  def configure_sign_in_params
    devise_parameter_sanitizer.permit :sign_in, keys: User::USER_PERMIT
  end

  def after_sign_in_path_for resource
    return admin_root_path if resource.admin?

    user_path resource
  end
end
