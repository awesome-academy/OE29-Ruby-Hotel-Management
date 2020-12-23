class BookingsController < ApplicationController
  layout "reservations", only: :index
  load_and_authorize_resource

  def index
    @bookings = Booking.by_bill_id params[:bill_id]
    @bill = @bookings.first.bill
  end
end
