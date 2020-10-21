class Booking < ApplicationRecord
  belongs_to :bill
  belongs_to :room

  has_many :booking_services, dependent: :destroy

  delegate :price, :name, to: :room, prefix: true

  enum status: {
    available: 0,
    unavailable: 1
  }
end
