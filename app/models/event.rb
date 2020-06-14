class Event < ApplicationRecord
  belongs_to :user

  validates :event_title, presence: true
	validates :event_content, presence: true
  validates :minimum_number_of_participant, presence: true
  # ジオコーディング用
  geocoded_by :address
  after_validation :geocode, if: :address_changed?
end
