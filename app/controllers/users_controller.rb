class UsersController < ApplicationController
  def new
    @users = User.all
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = t "global.text_check_email"
      redirect_to root_url
    else
      respond_to do |format|
        format.js
      end
    end
  end

  private

  def user_params
    params.required(:user).permit User::USER_PERMIT
  end
end
