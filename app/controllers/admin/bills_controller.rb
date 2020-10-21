class Admin::BillsController < AdminController
  def index
    @user = User.find params[:user_id]
    @bills = @user.bills.page(params[:page]).per Settings.bills_per_page
  end
end
