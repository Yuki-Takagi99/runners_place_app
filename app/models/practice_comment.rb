class PracticeComment < ApplicationRecord
  validates :practice_comment_content, presence: true
  belongs_to :practice_diary
end
