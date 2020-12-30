class RoomsController < ApplicationController
  before_action :load_room_by_id, :get_star, only: :show
  def index
    @q = Room.ransack params[:q], auth_object: set_ransackable_auth_object
    @rooms = @q.result(distinct: true)
               .page(params[:page]).per Settings.rooms.rooms_to_show
  end

  def show
    @relate_rooms = Room.not_current_room(@room.id)
                        .relate_room(@room.type_id)
                        .take Settings.rooms.relate_rooms
    @comment = Comment.new
  end

  private

  def load_room_by_id
    @room = Room.find params[:id]
  end

  def get_star
    @rate = if user_signed_in?
              current_user.rates.by_room_id(@room.id).first
            else
              Rate.by_room_id(@room.id).first
            end
  end
end
