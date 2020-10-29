class Admin::ReservationsController < AdminController
  before_action :find_bill, only: %i(show update)

  def index
    @reservations = reser_bill_range(params[:range])
                    .bill_created_at
                    .page(params[:page])
                    .per Settings.booking_per_page
    respond_to do |format|
      format.js
      format.html
    end
  end

  def show
    @bookings = @bill.bookings.page(params[:page]).per Settings.bills_per_page
  end

  def update
    @user = @bill.user
    status_params params[:data]
  end

  private

  def find_bill
    @bill = Bill.find params[:id]
    return if @bill
  end

  def status_params status
    if status == Settings.cancel
      cancel_action @bill
    elsif status == Settings.accept
      if @bill.accept!
        @user.send_activation_reservation @bill
        flash[:info] = t "global.accept"
        @reservations = Bill.waiting.bill_created_at.page(params[:page])
                            .per Settings.booking_per_page
        :js
      else
        flash[:danger] = t "global.cancel_error"
      end
    end
  end

  def cancel_action bill
    if bill.cancelled!
      flash[:info] = t "global.cancel_success"
    else
      flash[:danger] = t "global.cancel_error"
    end
  end

  def reser_bill_range range
    range.present? ? select_reser_range(range) : Bill.all
  end

  def select_reser_range range
    Bill.send range
  end
end
