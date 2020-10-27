class RoomsController < ApplicationController
  before_action :load_room_by_id, :get_star, only: :show
  def index
    @rooms = Room.page(params[:page]).per Settings.rooms.rooms_to_show
  end

  def show
    @relate_rooms = Room.all_not_current_room(@room.id)
                        .relate_room(@room.type_id)
                        .take Settings.rooms.relate_rooms
    @comment = Comment.new
  end

  private

  def load_room_by_id
    @room = Room.find params[:id]
  end

  def get_star
    @rate = current_user.rates.by_room_id(@room.id).first
  end
end
