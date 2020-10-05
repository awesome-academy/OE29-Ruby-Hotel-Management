module Admin::ViewsHelper
  def check_url_view view
    view.id.present? ? admin_view_path(view) : admin_views_path
  end
end
