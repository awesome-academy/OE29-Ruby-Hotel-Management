class Admin::RoomsController < AdminController
  before_action :load_room_by_id, only: :destroy

  def index
    @room = Room.new
    @rooms = Room.all.page(params[:page]).per Settings.rooms.room_per_page

    @type_arr = Type.pluck :name, :id
    @view_arr = View.pluck :name, :id
  end

  def create
    @room = Room.new room_params
    if @room.save
      flash[:success] = t ".room_created"
    else
      flash[:danger] = t ".room_not_create"
    end
    redirect_to admin_rooms_path
  end

  def destroy
    if @room.destroy
      flash[:success] = t ".room_deleted"
    else
      flash[:danger] = t ".room_not_deleted"
    end
    redirect_to admin_rooms_path
  end

  private

  def room_params
    params.require(:room).permit Room::ROOMS_PARAMS
  end

  def load_room_by_id
    @room = Room.find id: params[:id]
    return if @room

    flash[:danger] = t ".room_not_found"
    redirect_to admin_rooms_path
  end
end
