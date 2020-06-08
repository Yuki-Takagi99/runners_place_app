class PracticeFavorite < ApplicationRecord
  belongs_to :user
  belongs_to :practice_diary
end
