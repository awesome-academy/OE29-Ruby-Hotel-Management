class Service < ApplicationRecord
  SERVICES_PARAMS = %i(name price des unity_id).freeze
  belongs_to :unity

  has_many :booking_services, dependent: :destroy

  accepts_nested_attributes_for :booking_services

  validates :name, presence: true,
            length: {maximum: Settings.service.validate.name_max}
  validates :des, presence: true,
            length: {maximum: Settings.service.validate.des_max}
  validates :unity_id, presence: true
  validates :price, presence: true, numericality: {only_integer: true}
end
