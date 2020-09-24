class User < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :bill, dependent: :destroy

  enum gender: {
    male: 0,
    female: 1,
    other: 2
  }

  enum role: {
    client: 0,
    staff: 1,
    admin: 2
  }
end
