class AdminController < ApplicationController
  layout "admins"

  before_action :authenticate_user!

  private

  def correct_admin
    return if current_user&.admin?

    flash[:error] = "user not is admin"
    redirect_to root_path
  end
end
