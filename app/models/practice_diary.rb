class PracticeDiary < ApplicationRecord
	validates :practice_title, presence: true
	validates :practice_content, presence: true
	validates :practice_distance, presence: true
	validates :practice_time, presence: true
	belongs_to :user
	# お気に入り機能のアソシエーション
	has_many :practice_favorites, dependent: :destroy
	has_many :favorite_users, through: :practice_favorites, source: :user

	# コメント機能のアソシエーション
	has_many :practice_comments, dependent: :destroy
	
	# 練習時間表示の成型
	def set_practice_time
		practice_time.strftime("%-H時間%M分%S秒")
	end

	# 練習日表示の成型
	def set_practice_date
		practice_date.strftime("%Y年%m月%d日")
	end

	# いいね！しているかどうかを判断
	def favorited_by?(user)
		practice_favorites.where(user_id: user.id).exists?
	end

	# 当月の走行距離を取得
	scope :this_month_distance, -> { where(practice_date: Time.current.all_month).sum(:practice_distance).round(2) }

	# 現在のユーザの練習記録を取得
	scope :login_user_diary, -> (user) { where(user_id: "#{user}") }

	# 最近の練習記録を降順に表示
	scope :recent, -> { order(practice_date: :desc) }

	# タイトルで検索
	scope :search_title, -> (title) { where("practice_title LIKE ?", "%#{title}%") }

	# 詳細で検索
	scope :search_content, -> (content) { where("practice_content LIKE ?", "%#{content}%") }

end
