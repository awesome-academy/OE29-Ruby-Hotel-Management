class Booking < ApplicationRecord
  belongs_to :bill
  belongs_to :room

  has_many :booking_services, dependent: :destroy

  enum status: {
    available: 0,
    unavailable: 1
  }
end
