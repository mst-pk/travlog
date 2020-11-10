class Event < ApplicationRecord
  belongs_to :user
  has_many :event_pictures, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :users, through: :likes
  accepts_nested_attributes_for :event_pictures, allow_destroy: true
  geocoded_by :address
  after_validation :geocode, if: :address_changed?
end
