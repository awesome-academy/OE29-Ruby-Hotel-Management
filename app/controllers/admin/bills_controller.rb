class Admin::BillsController < AdminController
  before_action :correct_admin
  load_and_authorize_resource

  def index
    @user = User.find params[:user_id]
    @total_bill = @user.bills
    @bills = bill_range(params[:range]).bill_created_at
                                       .page(params[:page])
                                       .per Settings.user.page
    respond_to do |format|
      format.js
      format.html
    end
  end

  def show
    @bill = Bill.find params[:id]
    @bookings = @bill.bookings.page(params[:page])
                     .per Settings.user.page
    @booking_services = booking_services @bookings
    @bill_total = total_bill @bookings
  end

  def update
    @bill = Bill.find params[:id]
    @user = User.find @bill.user_id
    update_bill @bill
  end

  private

  def update_bill bill
    if bill.update(price: params[:price], status: Settings.complete)
      flash[:info] = t "global.complete"
      redirect_to admin_users_path
    else
      flash.now[:danger] = t "global.complete_error"
      render :show
    end
  end

  def booking_services bookings
    bookings.each do |booking|
      booking.booking_services.page(params[:page])
             .per Settings.user.page
    end
  end

  def total_bill bookings
    bookings.reduce(0){|a, e| a + e.price}
  end
end
