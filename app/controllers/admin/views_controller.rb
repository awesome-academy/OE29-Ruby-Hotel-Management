class Admin::ViewsController < AdminController
  before_action :load_view_by_id, only: %i(update destroy edit)

  load_and_authorize_resource

  def index
    @view = View.new
    @views = View.all
  end

  def create
    @view = View.new view_params
    if @view.save
      flash[:success] = t "global.create_success"
    else
      flash[:danger] = t "global.create_unsuccess"
    end
    redirect_to admin_views_path
  end

  def edit
    respond_to :js
  end

  def update
    if @view.update view_params
      flash[:success] = t "global.update_success"
    else
      flash[:danger] = t "global.update_unsuccess"
    end
    redirect_to admin_views_path
  end

  def destroy
    if @view.destroy
      flash[:success] = t "global.delete_success"
    else
      flash[:danger] = t "global.delete_unsuccess"
    end
    redirect_to admin_views_path
  end

  private

  def view_params
    params.require(:view).permit View::VIEWS_PARAMS
  end

  def load_view_by_id
    @view = View.find_by id: params[:id]
    return if @view

    flash[:danger] = t ".view_not_found"
    redirect_to admin_views_path
  end
end
