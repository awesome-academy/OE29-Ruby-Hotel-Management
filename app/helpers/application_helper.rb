module ApplicationHelper
  def full_title page_title
    base_title = t "global.app_name"
    page_title.blank? ? base_title : [page_title, base_title].join(" | ")
  end

  def current_path? path
    request.path.eql?(path) ? "active_menu" : " "
  end

  def current_path_admin? path
    request.path.eql?(path) ? "active nav-link" : "nav-link"
  end
end
