class RoomsController < ApplicationController
  before_action :load_room_by_id, only: :show
  def index
    @rooms = Room.page(params[:page]).per Settings.rooms.rooms_to_show
  end

  def show
    @relate_rooms = Room.relate_room(@room.type_id)
                        .take Settings.rooms.relate_rooms
  end

  private

  def load_room_by_id
    @room = Room.find params[:id]
    return if @room

    flash[:danger] = t ".room_not_found"
    redirect_to rooms_path
  end
end
