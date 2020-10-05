class Admin::UsersController < AdminController
  before_action :logged_in_user, :find_user, only: %i(edit show update)
  before_action :correct_user, only: %i(edit update)

  def edit; end

  def show; end

  def update
    if @user.update user_params
      flash[:success] = t "global.update_success"
      redirect_to [:admin, @user]
    else
      flash.now[:danger] = t "global.update_error"
      render :edit
    end
  end
end
