module Admin::UnitiesHelper
  def check_url_unity unity
    unity.id.present? ? admin_unity_path(unity) : admin_unities_path
  end
end
