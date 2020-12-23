class Bill < ApplicationRecord
  BILLS_PARAMS = [:status, :user_id, :price,
                  bookings_attributes: [:id, :price,
                                        :status, :checkin,
                                        :checkout,
                                        :room_id, :_destroy].freeze].freeze
  belongs_to :user

  has_many :bookings, dependent: :destroy
  accepts_nested_attributes_for :bookings, reject_if: :all_blank,
                                allow_destroy: true
  after_update :update_bill
  enum status: {
    waiting: 0,
    accept: 1,
    completed: 2,
    cancelled: 3
  }
  validates :price,
            presence: true,
            numericality: {only_integer: true, other_than: 0}
  delegate :name, :email, to: :user, prefix: true

  scope :bill_created_at, ->{order created_at: :desc}
  scope :select_range_created_at, (lambda do |start_date, end_date|
    if end_date.present? && end_date.present?
      where("created_at > '#{start_date}' AND created_at < '#{end_date}'")
    end
  end)

  def update_bill
    update_column :price, bookings.sum(:price)
  end
end
