class Room < ApplicationRecord
  belongs_to :view
  belongs_to :type

  has_many :comments, dependent: :destroy
  has_many :bookings, dependent: :destroy
end
