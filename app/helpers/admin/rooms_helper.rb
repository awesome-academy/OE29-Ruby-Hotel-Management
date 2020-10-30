module Admin::RoomsHelper
  def check_url_room room
    room.id.present? ? admin_room_path(room) : admin_rooms_path
  end

  def select_price_sort
    [[t(".select_sort_price"), nil],
     [t(".price_desc"), Settings.desc],
     [t(".price_asc"), Settings.asc]]
  end
end
