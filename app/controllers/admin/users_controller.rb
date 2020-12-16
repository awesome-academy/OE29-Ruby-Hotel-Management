class Admin::UsersController < AdminController
  load_and_authorize_resource

  def index
    @users = User.client.by_email(params[:data])
                 .page(params[:page])
                 .per Settings.users_per_page
    respond_to do |format|
      format.js
      format.html
    end
  end
end
