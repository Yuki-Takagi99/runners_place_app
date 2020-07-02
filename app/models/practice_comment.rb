class PracticeComment < ApplicationRecord
  validates :practice_comment_content, presence: true, length: { maximum: 150 }
  belongs_to :practice_diary
  belongs_to :user
  # 通知機能のアソシエーション
  has_many :notifications, dependent: :destroy
end
