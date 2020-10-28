class Booking < ApplicationRecord
  BOOKINGS_PARAMS = [:price, :status, :checkin, :checkout, :bill_id, :room_id,
                     booking_services_attributes: [:id, :amount,
                                        :service_id, :_destroy]].freeze

  belongs_to :bill
  belongs_to :room

  has_many :booking_services, dependent: :destroy
  belongs_to :user

  accepts_nested_attributes_for :booking_services, allow_destroy: true
  enum status: {
    available: 0,
    unavailable: 1
  }
  delegate :type_name, :price, :view_name, :name, :des, :pictures, to: :room,
           prefix: true

  scope :by_bill_id, ->(bill_id){where bill_id: bill_id if bill_id.present?}
end
