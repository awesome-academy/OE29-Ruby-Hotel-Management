class Admin::BookingServicesController < AdminController
  def new
    @booking_service = BookingServices.new
  end
end
