class Room < ApplicationRecord
  ROOMS_PARAMS = [:name, :price, :des, :view_id, :type_id,
                  pictures_attributes: [:id, :room_id,
                                        :picture, :_destroy].freeze].freeze

  belongs_to :view
  belongs_to :type

  has_many :comments, as: :commentable, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many :pictures, dependent: :destroy
  has_many :rates, dependent: :destroy

  accepts_nested_attributes_for :pictures, allow_destroy: true

  acts_as_paranoid

  validates :name, presence: true,
            length: {maximum: Settings.rooms.validate.name_max}
  validates :des, presence: true,
            length: {maximum: Settings.rooms.validate.des}
  validates :view_id, presence: true
  validates :type_id, presence: true
  validates :price,
            presence: true,
            numericality: {only_integer: true, other_than: 0}

  delegate :name, to: :type, prefix: true
  delegate :name, to: :view, prefix: true

  scope :relate_room, ->(type_ids){where type_id: type_ids}
  scope :by_ids, ->(room_ids){where id: room_ids}
  scope :valid_room, (lambda do |checkin, checkout|
    if checkin.present? && checkout.present?
      where("rooms.id NOT IN (SELECT DISTINCT rooms.id
        FROM rooms LEFT OUTER JOIN bookings ON bookings.room_id = rooms.id
        LEFT OUTER JOIN bills ON bills.id = bookings.bill_id
        WHERE ((bookings.checkin < '#{checkout}'
        AND bookings.checkout > '#{checkin}') AND bills.status != 3))")
    end
  end)
  scope :all_not_current_room, (lambda do |current_room|
    where("rooms.id != #{current_room}")
  end)
  scope :created_at, ->{order created_at: :asc}

  def average_score
    rates.average(:score).round(1, :truncate)
  end
end
