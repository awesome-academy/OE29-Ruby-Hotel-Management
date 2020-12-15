class Admin::BookingServicesController < AdminController
  load_and_authorize_resource

  def new
    @booking_service = BookingServices.new
  end
end
