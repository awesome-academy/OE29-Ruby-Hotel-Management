class BillsController < ApplicationController
  layout "reservations", only: :show
  load_and_authorize_resource

  before_action :find_bill, only: %i(show update)

  def index
    @data = {total: params[:total],
             count: params[:count],
             checkin: params[:checkin],
             checkout: params[:checkout]}
    @list_room = Room.by_ids params[:data]
    :js
  end

  def show
    @bookings = @bill.bookings
  end

  def create
    @bill = current_user.bills.build bill_params.merge(status: params[:status])
    if @bill.save
      flash[:info] = t "global.book_success"
      redirect_to user_path current_user.id
    else
      flash.now[:danger] = t "global.book_error"
      redirect_to reservations_path
    end
  end

  def update
    bookings_att = new_params update_bill(params[:bill][:bookings_attributes])
    if @bill.update bookings_att
      flash[:success] = t "global.update_success"
      redirect_to user_path current_user.id
    else
      flash.now[:danger] = t "global.upate_service_error"
      redirect_to bookings_path bill_id: params[:id]
    end
  end

  private

  def day_between checkin, checkout
    ((checkout.to_time - checkin.to_time) / Settings.mini).to_i + Settings.tm
  end

  def price_booking checkin, checkout, price
    price * day_between(checkin, checkout)
  end

  def new_params  bill_params
    main_params = {}
    bill_params.each_with_index do |item, index|
      main_params[index.to_s] = item
    end
    {
      "bookings_attributes": main_params
    }
  end

  def update_bill params
    params2 = Array.new
    params.values.each do |value|
      room_price = Room.find(value["room_id"]).price
      price = price_booking(value[:checkin], value[:checkout], room_price)
      params2 << value.merge(price: price)
    end
    params2
  end

  def bill_params
    params.permit Bill::BILLS_PARAMS
  end

  def find_bill
    @bill = Bill.find params[:id]
  end
end
