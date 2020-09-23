class View < ApplicationRecord
  has_many :rooms, dependent: :destroy
end
