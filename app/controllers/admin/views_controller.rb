class Admin::ViewsController < AdminController
  before_action :load_view_by_id, only: %i(update destroy edit)
  def index
    @view = View.new
    @views = View.all
  end

  def create
    @view = View.new view_params
    if @view.save
      flash[:success] = t ".view_created"
    else
      flash[:danger] = t ".view_not_create"
    end
    redirect_to admin_views_path
  end

  def edit
    respond_to :js
  end

  def update
    if @view.update view_params
      flash[:success] = t ".view_updated"
    else
      flash.now[:danger] = t ".view_not_update"
    end
    redirect_to admin_views_path
  end

  def destroy
    if @view.destroy
      flash[:success] = t ".view_deleted"
    else
      flash[:danger] = t ".view_not_deleted"
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
