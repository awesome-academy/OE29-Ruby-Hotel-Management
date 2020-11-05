class BookingService < ApplicationRecord
  belongs_to :booking
  belongs_to :service

  validates :service_id, presence: true,
            numericality: {only_integer: true, greater_than: Settings.inter}
  validates :amount, presence: true,
            numericality: {only_integer: true, greater_than: Settings.inter}

  delegate :price, :name, to: :service, prefix: true
end
