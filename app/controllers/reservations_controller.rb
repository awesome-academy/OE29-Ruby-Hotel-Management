class ReservationsController < ApplicationController
  def index
    if params[:checkin].present? && params[:checkout].present?
      @rooms = Room.empty_at params[:checkin], params[:checkout]
    else
      flash[:danger] = t "global.search_fail"
      redirect_to new_reservation_path
    end
  end

  def create
    @booking = params[:data]
    :js
  end

  def show; end

  def new; end
end
