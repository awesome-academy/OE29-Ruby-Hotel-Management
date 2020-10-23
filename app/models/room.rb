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

  acts_as_paranoid

  validates :name, presence: true,
            length: {maximum: Settings.rooms.validate.name_max}
  validates :des, presence: true,
            length: {maximum: Settings.rooms.validate.des}
  validates :view_id, presence: true
  validates :type_id, presence: true
  validates :price, presence: true, numericality: {only_integer: true}

  delegate :name, to: :type, prefix: true
  delegate :name, to: :view, prefix: true

  scope :relate_room, ->(type_ids){where type_id: type_ids}
  scope :by_ids, ->(room_ids){where id: room_ids}
  scope :empty_at, (lambda do |checkin, checkout|
    if checkin.present? && checkout.present?
      where("rooms.id NOT IN (SELECT rooms.id
      from rooms JOIN bookings
      ON rooms.id = bookings.room_id
      WHERE (bookings.checkin < '#{checkin}'
      AND bookings.checkout > '#{checkout}')
      OR (bookings.checkout BETWEEN '#{checkin}' AND '#{checkout}')
      OR (bookings.checkin BETWEEN '#{checkin}' AND '#{checkout}'))")
    end
  end)
end
