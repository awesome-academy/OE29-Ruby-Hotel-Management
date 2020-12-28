module ApplicationHelper
  def full_title page_title
    base_title = t "global.app_name"
    page_title.blank? ? base_title : [page_title, base_title].join(" | ")
  end

  def toastr_flash type
    case type
    when "danger"
      "toastr.error"
    when "success"
      "toastr.success"
    else
      "toastr.info"
    end
  end

  def current_path? path
    request.path.eql?(path) ? "active_menu" : " "
  end

  def current_path_admin? path
    request.path.eql?(path) ? "active nav-link" : "nav-link"
  end

  def price_booking book
    (((book.checkout - book.checkin) / Settings.mini).to_i + 1) *
      book.room_price
  end

  def price_bill booking_service
    booking_service.service.price * booking_service.amount
  end

  def index_of_page object
    (object.current_page - 1) * object.limit_value + 1
  end

  def option_status_bill
    bill = Bill.statuses.map{|key, value| [t("global.#{key}"), value]}
    bill.push [t("global.all"), ""]
  end

  def option_room_empty checkin, checkout
    Room.valid_room checkin, checkout
  end

  def option_service
    service = Service.all.map{|key, _value| [t("global.#{key}"), key]}
    service.push [t("global.all"), t("global.all").downcase]
  end

  def add_on_class number, score
    number <= score ? "on" : ""
  end
end
