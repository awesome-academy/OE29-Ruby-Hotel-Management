class Admin::BillsController < AdminController
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
end
