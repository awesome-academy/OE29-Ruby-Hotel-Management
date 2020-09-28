class View < ApplicationRecord
  VIEWS_PARAMS = :name

  has_many :rooms, dependent: :destroy

  validates :name, presence: true,
            length: {maximum: Settings.room_view.validate.name_max}
end
