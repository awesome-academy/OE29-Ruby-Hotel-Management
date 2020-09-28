class Room < ApplicationRecord
  ROOMS_PARAMS = [:name, :price, :des, :view_id, :type_id,
                  pictures_attributes: [:id, :room_id,
                                        :picture, :_destroy].freeze].freeze

  belongs_to :view
  belongs_to :type

  has_many :comments, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many :pictures, dependent: :destroy

  accepts_nested_attributes_for :pictures, allow_destroy: true

  validates :name, presence: true,
            length: {maximum: Settings.rooms.validate.name_max}
  validates :des, presence: true,
            length: {maximum: Settings.rooms.validate.des}
  validates :view_id, presence: true
  validates :type_id, presence: true
  validates :price, presence: true, numericality: {only_integer: true}

  delegate :name, to: :type, prefix: true
  delegate :name, to: :view, prefix: true
end
