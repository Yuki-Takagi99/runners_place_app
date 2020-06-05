class PracticeDiary < ApplicationRecord
	validates :practice_title, presence: true
	validates :practice_content, presence: true
	validates :practice_distance, presence: true
	validates :practice_time, presence: true

	# 練習時間表示の成型
	def set_practice_time
		practice_time.strftime("%-H時間%M分%S秒")
	end
end
