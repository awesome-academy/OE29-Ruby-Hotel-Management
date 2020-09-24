module ApplicationHelper
  def full_title page_title
    base_title = t "global.app_name"
    page_title.blank? ? base_title : [page_title, base_title].join(" | ")
  end
end
