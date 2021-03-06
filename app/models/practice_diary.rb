class PracticeDiary < ApplicationRecord
  validates :practice_date, presence: true
  validates :practice_title, presence: true, length: { maximum: 100 }
  validates :practice_content, presence: true, length: { maximum: 1000 }
  validates :practice_distance, presence: true, numericality: { greater_than: 0.1 }
  validates :practice_time, presence: true
  validate  :date_not_after_today

  belongs_to :user
  # お気に入り機能のアソシエーション
  has_many :practice_favorites, dependent: :destroy
  has_many :favorite_users, through: :practice_favorites, source: :user
  # コメント機能のアソシエーション
  has_many :practice_comments, dependent: :destroy
  # 通知機能のアソシエーション
  has_many :notifications, dependent: :destroy

  # 練習時間表示の成型
  def set_practice_time
    practice_time.strftime("%-H時間%M分%S秒")
  end

  # 練習日表示の成型
  def set_practice_date
    practice_date.strftime("%Y年%-m月%-d日(#{I18n.t('date.abbr_day_names')[practice_date.wday]})")
  end

  # いいね！しているかどうかを判断
  def favorited_by?(user)
    practice_favorites.where(user_id: user.id).exists?
  end

  # 本日以降の日程を選択させないようにバリデーションを追加
  def date_not_after_today
    errors.add(:practice_date, "は本日以前の日付を選択してください") if practice_date.nil? || practice_date.future?
  end

  # 当月の走行距離を取得
  scope :this_month_distance, -> { where(practice_date: Time.current.all_month).sum(:practice_distance).round(2) }

  # 現在のユーザの練習記録を取得
  scope :login_user_diary, -> (user) { where(user_id: "#{user}") }

  # ログインユーザ以外の練習記録を取得
  scope :other_user_diary, -> (user) { where.not(user_id: "#{user}") }

  # 最近の練習記録を降順に表示
  scope :recent, -> { order(practice_date: :desc) }

  # 練習記録の検索
  scope :search, -> (search_params) do
    # search_paramsが空の場合、以降の処理を行わない
    return if search_params.blank?

    # 検索パラメータを指定する
    practice_title(search_params[:practice_title])
      .practice_content(search_params[:practice_content])
      .practice_date_from(search_params[:practice_date_from])
      .practice_date_to(search_params[:practice_date_to])
      .user_name(search_params[:user_name])
  end

  # practice_titleが存在する場合、like検索する
  scope :practice_title, -> (practice_title) { where('practice_title LIKE ?', "%#{practice_title}%") if practice_title.present? }
  # practice_contentが存在する場合、like検索する
  scope :practice_content, -> (practice_content) { where('practice_content LIKE ?', "%#{practice_content}%") if practice_content.present? }
  # practice_dateが存在する場合、範囲検索する
  scope :practice_date_from, -> (from) { where('? <= practice_date', from) if from.present? }
  scope :practice_date_to, -> (to) { where('practice_date <= ?', to) if to.present? }
  # ユーザー名で検索する
  scope :user_name, -> (user_name) { where('users.user_name LIKE ?', "%#{user_name}%").references(:users) if user_name.present? }

  # いいね通知機能
  def create_notification_favorite!(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and practice_diary_id = ? and action = ? ", current_user.id, user_id, id, 'favorite'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        practice_diary_id: id,
        visited_id: user_id,
        action: 'favorite'
      )

      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  # 練習記録コメント通知機能
  def create_notification_comment!(current_user, practice_comment_id)
    #同じ投稿にコメントしているユーザーに通知を送る。（current_userと投稿ユーザーのぞく）
    temp_ids = PracticeComment.where(practice_diary_id: id).where.not("user_id = ? or user_id = ?", current_user.id, user_id).select(:user_id).distinct
    #取得したユーザー達へ通知を作成（user_idのみ繰り返し取得）
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, practice_comment_id, temp_id['user_id'])
    end
    #投稿者へ通知を作成
    save_notification_comment!(current_user, practice_comment_id, user_id)
  end

  def save_notification_comment!(current_user, practice_comment_id, visited_id)
    notification = current_user.active_notifications.new(
      practice_diary_id: id,
      practice_comment_id: practice_comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end
end
