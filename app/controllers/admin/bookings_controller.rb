class Admin::BookingsController < AdminController
  before_action :find_booking, only: %i(show edit)
  after_action :update_booking, only: :update

  load_and_authorize_resource

  def index
    @service = Service.new
    @user = User.find params[:user_id]
    @bill = Bill.find params[:bill_id]
    @bookings = @bill.bookings.page(params[:page]).per Settings.booking_per_page
  end

  def edit; end

  def show; end

  def update
    @booking = Booking.find params[:id]
    if @booking.update booking_params
      flash[:success] = t "global.update_success"
      redirect_to admin_booking_path(params[:id])
    else
      flash.now[:danger] = t "global.upate_service_error"
      render :edit
    end
  end

  private

  def update_booking
    day = ((@booking.checkout - @booking.checkin) / Settings.mini) + Settings.tm
    total_price = @booking.room.price * day.to_i + price(@booking)
    @booking.update(price: total_price)
  end

  def price book
    book.booking_services.reduce(0){|a, e| a + e.service.price * e.amount}
  end

  def booking_params
    params.require(:booking).permit Booking::BOOKINGS_PARAMS
  end

  def find_booking
    @booking = Booking.find params[:id]
  end
end
