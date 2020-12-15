class Admin::TypesController < AdminController
  before_action :load_type_by_id, only: %i(update destroy edit)

  load_and_authorize_resource

  def index
    @type = Type.new
    @types = Type.all
  end

  def create
    @type = Type.new type_params
    if @type.save
      flash[:success] = t "global.create_success"
    else
      flash[:danger] = t "global.create_unsuccess"
    end
    redirect_to admin_types_path
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def update
    if @type.update type_params
      flash[:success] = t "global.update_success"
    else
      flash[:danger] = t "global.update_unsuccess"
    end
    redirect_to admin_types_path
  end

  def destroy
    if @type.destroy
      flash[:success] = t "global.delete_success"
    else
      flash[:danger] = t "global.delete_unsuccess"
    end
    redirect_to admin_types_path
  end

  private

  def type_params
    params.require(:type).permit Type::TYPES_PARAMS
  end

  def load_type_by_id
    @type = Type.find_by id: params[:id]
    return if @type

    flash[:danger] = t ".type_not_found"
    redirect_to admin_types_path
  end
end
