class Bill < ApplicationRecord
  BILLS_PARAMS = [:status, :user_id, :price,
                  bookings_attributes: [:id, :price,
                                        :status, :checkin,
                                        :checkout,
                                        :room_id].freeze].freeze
  belongs_to :user

  has_many :bookings, dependent: :destroy
  accepts_nested_attributes_for :bookings, allow_destroy: true

  enum status: {
    waiting: 0,
    accept: 1,
    completed: 2,
    cancelled: 3
  }

  scope :bill_created_at, ->{order created_at: :desc}
  scope :select_range_created_at, (lambda do |start_date, end_date|
    if end_date.present? && end_date.present?
      where("created_at > '#{start_date}' AND created_at < '#{end_date}'")
    end
  end)
end
