class Admin::BookingsController < AdminController
  def index
    @user = User.find params[:user_id]
    @bill = Bill.find params[:bill_id]
    @bookings = @bill.bookings.page(params[:page]).per Settings.booking_per_page
  end

  def show
    @booking = Booking.find params[:id]
  end
end
