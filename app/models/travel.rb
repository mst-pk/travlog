class Travel < ApplicationRecord
  belongs_to :user
  has_many :events, dependent: :destroy
  has_many :favorites, dependent: :destroy
  mount_uploader :travel_image, ImageUploader
  
  enum genre: { 国内: 0, 海外: 1 }
  
  validates :title, presence: true, length: { maximum: 50 }
  validates :genre, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  
  def self.search(search)
    if search
      Travel.where(genre: search)
    else
      Travel.all
    end
  end
end
