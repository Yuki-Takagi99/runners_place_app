class ParticipantManagement < ApplicationRecord
  validates :user_id, presence: true, uniqueness: {scope: :event_id}
  validates :event_id, presence: true
  belongs_to :user
  belongs_to :event
end
