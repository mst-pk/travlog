class Event < ApplicationRecord
  belongs_to :user
  has_many :event_pictures, dependent: :destroy
  accepts_nested_attributes_for :event_pictures, allow_destroy: true
end
