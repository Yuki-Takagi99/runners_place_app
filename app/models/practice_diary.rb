class PracticeDiary < ApplicationRecord
	validates :practice_title, presence: true
	validates :practice_content, presence: true
	validates :practice_distance, presence: true
end
