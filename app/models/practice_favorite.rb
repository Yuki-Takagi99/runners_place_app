class PracticeFavorite < ApplicationRecord
  validates :user_id, presence: true, uniqueness: {scope: :practice_diary_id}
  validates :practice_diary_id, presence: true
  belongs_to :user
  belongs_to :practice_diary
end
