class BookingsController < ApplicationController
  layout "reservations", only: :index
  load_and_authorize_resource

  def index
    @bill = Bill.find params[:bill_id]
    @bookings = @bill.bookings
    @room_options = option_room_empty(@bookings.first)
  end

  private

  def option_room_empty booking
    Room.valid_room(booking.checkin, booking.checkout).pluck :name, :id
  end
end
