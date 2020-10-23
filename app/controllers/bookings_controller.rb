class BookingsController < ApplicationController
  def show
    @bookings = Booking.by_bill_id params[:id]
    respond_to do |format|
      format.js
      format.html
    end
  end
end
