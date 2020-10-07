module Admin::RoomsHelper
  def check_url_room room
    room.id.present? ? admin_room_path(room) : admin_rooms_path
  end
end
