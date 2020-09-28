class Admin::ServicesController < AdminController
  before_action :load_service_by_id, only: %i(update edit destroy)
  before_action :load_unity_array, only: %i(index edit)
  def index
    @service = Service.new
    @services = Service.all
  end

  def create
    @service = Service.new service_params
    if @service.save
      flash[:success] = t ".service_created"
    else
      flash[:danger] = t ".service_not_create"
    end
    redirect_to admin_services_path
  end

  def edit
    respond_to :js
  end

  def update
    if @service.update service_params
      flash[:success] = t ".service_updated"
    else
      flash.now[:danger] = t ".service_not_update"
    end
    redirect_to admin_services_path
  end

  def destroy
    if @service.destroy
      flash[:success] = t ".service_deleted"
    else
      flash[:danger] = t ".service_not_deleted"
    end
    redirect_to admin_services_path
  end

  private

  def service_params
    params.require(:service).permit Service::SERVICES_PARAMS
  end

  def load_service_by_id
    @service = Service.find_by id: params[:id]
    return if @service

    flash[:danger] = t ".service_not_found"
    redirect_to admin_services_path
  end

  def load_unity_array
    @unity_array = Unity.pluck :name, :id
  end
end
