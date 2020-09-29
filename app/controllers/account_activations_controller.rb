class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by email: params[:email]
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      flash[:success] = t "global.acc_activated"
    else
      flash[:danger] = t "global.invalidate_activation_link"
    end
    redirect_to root_url
  end
end
