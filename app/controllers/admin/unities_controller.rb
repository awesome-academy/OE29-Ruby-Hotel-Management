class Admin::UnitiesController < AdminController
  before_action :load_unity_by_id, only: %i(update destroy edit)

  def index
    @unity = Unity.new
    @unities = Unity.all
  end

  def create
    @unity = Unity.new unity_params
    if @unity.save
      flash[:success] = t "global.create_success"
    else
      flash[:danger] = t "global.create_unsuccess"
    end
    redirect_to admin_unities_path
  end

  def edit
    respond_to :js
  end

  def update
    if @unity.update unity_params
      flash[:success] = t "global.update_success"
    else
      flash[:danger] = t "global.update_unsuccess"
    end
    redirect_to admin_unities_path
  end

  def destroy
    if @unity.destroy
      flash[:success] = t "global.delete_success"
    else
      flash[:danger] = t "global.delete_unsuccess"
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
