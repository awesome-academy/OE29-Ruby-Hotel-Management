class Bill < ApplicationRecord
  belongs_to :user

  has_many :bookings, dependent: :destroy

  enum status: {
    waiting: 0,
    deposited: 1,
    completed: 2,
    cancelled: 3
  }
end
