class BillsController < ApplicationController
  def index
    @data = {total: params[:total],
             count: params[:count],
             checkin: params[:checkin],
             checkout: params[:checkout]}
    @list_room = Room.by_ids params[:data]
    :js
  end

  def show; end

  def create
    @bill = current_user.bills.build bill_params.merge(status: params[:status])
    if @bill.save
      flash[:info] = t "global.book_success"
      redirect_to user_path(current_user.id)
    else
      flash.now[:danger] = t "global.book_error"
      redirect_to reservations_path
    end
  end

  def update
    @bill = Bill.find params[:id]
    if @bill.cancelled!
      flash[:info] = t "global.cancel_success"
    else
      flash[:danger] = t "global.cancel_error"
    end
    @bills = current_user.bills.waiting.page(params[:page])
                         .per Settings.bill.page
    :js
  end

  private

  def bill_params
    params.permit Bill::BILLS_PARAMS
  end
end
