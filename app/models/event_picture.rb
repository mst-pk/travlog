class EventPicture < ApplicationRecord
  belongs_to :event
  mount_uploader :picture, ImageUploader
end
