class OrdersController < ApplicationController
  layout "reservations", only: %i(show edit)
  before_action :authenticate_user!, :find_user

  def show
    @q = @resource.bills.ransack params[:q]
    @bills = @q.result.page(params[:page]).per Settings.user.page
    respond_to do |format|
      format.js
      format.html
    end
  end

  private

  def find_user
    @resource = User.find params[:id]
  end
end
