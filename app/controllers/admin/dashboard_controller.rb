class Admin::DashboardController < AdminController
  def index
    @clients = User.client
    @rooms = Room.all
    @bills = Bill.all
    @_bills_history = Bill.group_by_day(:created_at,
                                        range: 1.week.ago..Time.zone.now).count
  end

  def bill_history
    if params[:start_date].blank?
      range = params[:range].to_i
      @_bills_history = select_range range
    else
      start_date = params[:start_date]
      end_date = params[:end_date]
      @_bills_history = Bill.select_range_created_at(start_date, end_date)
                            .group_by_day(:created_at).count
    end
    respond_to do |f|
      f.js{render template: "admin/dashboard/bill_history", layout: false}
    end
  end

  def income_bill
    render json: Bill.group_by_week(:created_at).sum(:price)
  end

  private

  def select_range range
    group_bill = lambda do |unit|
      Bill.group_by_day(:created_at,
                        range: unit.ago..Time.zone.now)
          .count
    end

    case range
    when 2
      group_bill.call(1.month)
    when 3
      group_bill.call(3.months)
    else
      group_bill.call(1.week)
    end
  end
end
