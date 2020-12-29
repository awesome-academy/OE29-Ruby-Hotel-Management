class BookingsController < ApplicationController
  layout "reservations", only: :index
  load_and_authorize_resource

  def index
    @bookings = Booking.by_bill_id params[:bill_id]
    booking = @bookings.first
    @bill = booking.bill
    @room_options = option_room_empty(booking)
  end

  private

  def option_room_empty booking
    Room.valid_room(booking.checkin, booking.checkout).pluck :name, :id
  end
end
