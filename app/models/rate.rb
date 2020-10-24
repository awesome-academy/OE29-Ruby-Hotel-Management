class Rate < ApplicationRecord
  RATE_PARAMS = %w(room_id user_id score).freeze

  belongs_to :user
  belongs_to :room

  scope :by_room_id, ->(room_id){where room_id: room_id}
end
