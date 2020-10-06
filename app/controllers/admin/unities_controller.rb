class Admin::UnitiesController < AdminController
  before_action :load_unity_by_id, only: %i(update destroy edit)

  def index
    @unity = Unity.new
    @unities = Unity.all
  end

  def create
    @unity = Unity.new unity_params
    if @unity.save
      flash[:success] = t ".unity_created"
    else
      flash[:danger] = t ".unity_not_create"
    end
    redirect_to admin_unities_path
  end

  def edit
    respond_to :js
  end

  def update
    if @unity.update unity_params
      flash[:success] = t ".unity_updated"
    else
      flash.now[:danger] = t ".unity_not_update"
    end
    redirect_to admin_unities_path
  end

  def destroy
    if @unity.destroy
      flash[:success] = t ".unity_deleted"
    else
      flash[:danger] = t ".unity_not_deleted"
    end
    redirect_to admin_unities_path
  end

  private

  def unity_params
    params.require(:unity).permit Unity::UNITIES_PARAMS
  end

  def load_unity_by_id
    @unity = Unity.find_by id: params[:id]
    return if @unity

    flash[:danger] = t ".unity_not_found"
    redirect_to admin_unities_path
  end
end
