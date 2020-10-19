class BillsController < ApplicationController
  def index
    @data = {total: params[:total],
             count: params[:count]}
    @list_room = Room.by_ids params[:data]
    :js
  end

  def create
    @bill = current_user.bill.build bill_params.merge(status: params[:status])
    if @bill.save
      flash[:info] = t "global.book_success"
      redirect_to root_path
    else
      flash.now[:danger] = t "global.book_error"
      redirect_to reservations_path
    end
  end

  private
  def bill_params
    params.permit Bill::BILLS_PARAMS
  end
end
