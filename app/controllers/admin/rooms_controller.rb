class Admin::RoomsController < AdminController
  before_action :load_room_by_id, only: %i(destroy edit update)
  before_action :load_type_view_room, only: %i(edit new create update)

  def index
    @rooms = Room.without_deleted.page(params[:page])
                 .created_at
                 .per Settings.rooms.room_per_page
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new room_params
    if @room.save
      flash[:success] = t "global.create_success"
      redirect_to admin_rooms_path
    else
      flash.now[:danger] = t "global.create_unsuccess"
      render :new
    end
  end

  def edit; end

  def update
    if @room.update room_params
      flash[:success] = t "global.update_success"
      redirect_to admin_rooms_path
    else
      flash.now[:danger] = t "global.update_unsuccess"
      render :edit
    end
  end

  def destroy
    if @room.bookings.available.present?
      flash[:danger] = t "global.delete_unsuccess"
    else
      @room.destroy
      flash[:success] = t "global.delete_success"
    end
    redirect_to admin_rooms_path
  end

  private

  def room_params
    params.require(:room).permit Room::ROOMS_PARAMS
  end

  def load_room_by_id
    @room = Room.find params[:id]
  end

  def load_type_view_room
    @type_arr = Type.pluck :name, :id
    @view_arr = View.pluck :name, :id
  end
end
