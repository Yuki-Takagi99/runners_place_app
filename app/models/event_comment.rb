class EventComment < ApplicationRecord
  validates :event_comment_content, presence: true, length: { maximum: 150 }
  belongs_to :user
  belongs_to :event
end
