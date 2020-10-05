class Type < ApplicationRecord
  TYPES_PARAMS = :name

  has_many :rooms, dependent: :destroy

  validates :name, presence: true,
            length: {maximum: Settings.type.validate.name_max}
end
