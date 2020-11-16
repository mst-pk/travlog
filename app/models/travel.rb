class Travel < ApplicationRecord
  belongs_to :user
  has_many :events, dependent: :destroy
  mount_uploader :travel_image, ImageUploader
  
  enum genre: { 国内: 0, 海外: 1 }
end
