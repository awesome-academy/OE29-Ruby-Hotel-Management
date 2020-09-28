module Admin::ServicesHelper
  def check_url_service service
    service.id.present? ? admin_service_path(service) : admin_services_path
  end
end
