class ReservationsController < ApplicationController
  layout "reservations"
  before_action :authenticate_user!
  def index
    authorize! :read, :reservation
    @rooms = Room.valid_room(params[:checkin], params[:checkout])
                 .page(params[:page])
                 .per Settings.reservation.page
    @checkin = params[:checkin]
    @checkout = params[:checkout]
  end

  def show
    authorize! :read, :reservation
    @room = Room.find params[:id]
    @rooms = Room.valid_room(params[:checkin_room], params[:checkout_room])
    @available = @rooms.include? @room
    respond_to do |format|
      format.html{redirect_to @room}
      format.js
    end
  end

  def update
    @bill = Bill.find params[:id]
    if @bill.cancelled!
      flash[:info] = t "global.cancel_success"
      @bills = current_user.bills.waiting.bill_created_at.page(params[:page])
                           .per Settings.bill.page
    else
      flash[:danger] = t "global.cancel_error"
    end
  end
end
