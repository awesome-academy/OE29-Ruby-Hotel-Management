class Unity < ApplicationRecord
  has_many :services, dependent: :destroy
end
