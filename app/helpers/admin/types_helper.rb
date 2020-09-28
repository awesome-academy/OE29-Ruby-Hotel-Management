module Admin::TypesHelper
  def check_url_type type
    type.id.present? ? admin_type_path(type) : admin_types_path
  end
end
