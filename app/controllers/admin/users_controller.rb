class Admin::UsersController < AdminController
  def index
    @users = User.client.page(params[:page]).per Settings.users_per_page
  end
end
