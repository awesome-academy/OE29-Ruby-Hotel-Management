class BookingsController < ApplicationController
  load_and_authorize_resource

  def index
    @bookings = Booking.by_bill_id params[:bill_id]
    respond_to do |format|
      format.js
      format.html
    end
  end
end
