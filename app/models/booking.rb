class Booking < ApplicationRecord
  belongs_to :bill
  belongs_to :room

  has_many :booking_services, dependent: :destroy

  enum status: {
    available: 0,
    unavailable: 1
  }
  delegate :type_name, :price, :view_name, :name, :des, :pictures, to: :room,
           prefix: true

  scope :by_bill_id, ->(bill_id){where bill_id: bill_id if bill_id.present?}
end
