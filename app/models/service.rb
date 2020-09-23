class Service < ApplicationRecord
  belongs_to :unity

  has_many :booking_services, dependent: :destroy
end
