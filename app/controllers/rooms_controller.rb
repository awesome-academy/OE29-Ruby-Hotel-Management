class RoomsController < ApplicationController
  before_action :load_room_by_id, only: :show
  def index
    @type_arr = Type.pluck :name, :id
    @view_arr = View.pluck :name, :id
    if params[:term]
      @rooms = Room.client_search_room(params[:term])
      filter_room_by_attr
    elsif params[:filter].present?
      @rooms = Room.client_search_room(params[:param_term])
                   .client_search_room(params[:term])
      filter_room_by_attr
    else
      @rooms = Room.page(params[:page])
                   .per Settings.rooms.rooms_to_show
    end
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

  def filter_room_by_attr
    @rooms = @rooms.by_type_id(params[:type_id]) if params[:type_id].present?
    @rooms = @rooms.by_view_id(params[:view_id]) if params[:view_id].present?

    price_id = params[:price_id].to_i
    @rooms = @rooms.by_price_top_to_bot if price_id == 1
    @rooms = @rooms.by_price_bot_to_top if price_id == 2
    @rooms = @rooms.page(params[:page]).per Settings.rooms.rooms_to_show
    respond_to :js
  end
end
