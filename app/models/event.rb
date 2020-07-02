class Event < ApplicationRecord
  validates :event_date, presence: true
  validate :date_not_before_today
  validates :event_title, presence: true, length: { maximum: 100 }
  validates :event_content, presence: true, length: { maximum: 1000 }
  validates :minimum_number_of_participant, presence: true, numericality: { greater_than: 0 }
  validates :address, presence: true, length: { maximum: 50 }

  # ユーザーとのアソシエーション
  belongs_to :user
  # イベント参加機能のアソシエーション
  has_many :participant_managements, dependent: :destroy
  has_many :participant_users, through: :participant_managements, source: :user
  # コメント機能のアソシエーション
  has_many :event_comments, dependent: :destroy
  # 通知機能のアソシエーション
  has_many :notifications, dependent: :destroy

  # ジオコーディング用
  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  # event_dateの表示形式を変更
  def set_event_date
    event_date.strftime("%Y年%-m月%-d日(#{I18n.t('date.abbr_day_names')[event_date.wday]}) %H時%M分")
  end

  # 本日以前の日程を選択させないようにバリデーションを追加
  def date_not_before_today
    errors.add(:event_date, "は本日以降の日付を選択してください") if event_date.nil? || event_date < Date.today
  end

  # イベント参加しているかどうかの判断
  def participated_by?(user)
    participant_managements.where(user_id: user.id).exists?
  end

  # 本日以前のイベントは表示せず、開催日時が近いイベント順に表示
  scope :recent, -> { where('event_date >= ?', Date.today ).order(event_date: :asc) }

  # イベントコメント通知機能
  def create_notification_event_comment!(current_user, event_comment_id)
    #同じ投稿にコメントしているユーザーに通知を送る。（current_userと投稿ユーザーのぞく）
    temp_ids = EventComment.where(event_id: id).where.not("user_id = ? or user_id = ?", current_user.id, user_id).select(:user_id).distinct
    #取得したユーザー達へ通知を作成。（user_idのみ繰り返し取得）
    temp_ids.each do |temp_id|
      save_notification_event_comment!(current_user, event_comment_id, temp_id['user_id'])
    end
    #投稿者へ通知を作成
    save_notification_event_comment!(current_user, event_comment_id, user_id)
  end

  def save_notification_event_comment!(current_user, event_comment_id, visited_id)
      notification = current_user.active_notifications.new(
        event_id: id,
        event_comment_id: event_comment_id,
        visited_id: visited_id,
        action: 'event_comment'
      )
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
  end

  # イベント参加通知機能
  def create_notification_paticipant!(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and event_id = ? and action = ? ", current_user.id, user_id, id, 'paticipant_management'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        event_id: id,
        visited_id: user_id,
        action: 'paticipant_management'
      )

      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end
end
