class ReservationsController < ApplicationController
  def index
    @rooms = Room.empty_at params[:checkin], params[:checkout]
  end

  def new; end
end
