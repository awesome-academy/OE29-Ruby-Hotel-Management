class UsersController < ApplicationController
  layout "reservations", only: %i(show edit)
  before_action :authenticate_user!
  def new
    @users = User.all
  end

  def show
    @resource = User.find params[:id]
    @bills = bill_range(params[:range]).bill_created_at.page(params[:page])
                                       .per Settings.user.page
    respond_to do |format|
      format.js
      format.html
    end
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = t "global.text_check_email"
      redirect_to root_url
    else
      respond_to :js
    end
  end

  def edit; end

  def update
    if @user.update user_params
      flash[:success] = t "global.update_success"
      redirect_to @user
    else
      flash.now[:danger] = t "global.update_error"
      render :edit
    end
  end

  private

  def bill_range range
    range.present? ? select_range(range) : @resource.bills
  end
end
