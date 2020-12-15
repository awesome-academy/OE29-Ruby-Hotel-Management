class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  before_action :set_locale

  def render_404
    render file: Rails.root.join("public", "404.html").to_s, layout: false,
           status: :not_found
  end

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def user_params
    params.required(:user).permit User::USER_PERMIT
  end

  def find_user
    @resource = User.find params[:id]
  end

  def bill_range range
    range.present? ? select_range(range) : @user.bills
  end

  def select_range range
    @resource.bills.send range
  end
end
