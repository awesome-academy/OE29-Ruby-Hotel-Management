class ReservationsController < ApplicationController
  layout "reservations"
  def index
    @rooms = Room.valid_room(params[:checkin], params[:checkout])
                 .page(params[:page]).per Settings.reservation.page
    @checkin = params[:checkin]
    @checkout = params[:checkout]
  end

  def show; end
end
