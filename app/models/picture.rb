class Picture < ApplicationRecord
  belongs_to :room

  mount_uploader :picture, PictureUploader
  validates :picture, presence: true
end
