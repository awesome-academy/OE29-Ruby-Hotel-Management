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

  def index_of_page object
    (object.current_page - 1) * object.limit_value + 1
  end

  def option_status_bill
    Bill.statuses.map{|key, value| [t(".#{key}"), value]}
  end
end
