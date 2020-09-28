class Unity < ApplicationRecord
  UNITIES_PARAMS = :name

  has_many :services, dependent: :destroy

  validates :name, presence: true,
            length: {maximum: Settings.unity.validate.name_max}
end
