class Picture < ApplicationRecord
  belongs_to :room

  mount_uploader :picture, PictureUploader
end
