class User < ApplicationRecord
  # Userモデルのバリデーション
  validates :user_name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, uniqueness: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  mount_uploader :image, ImageUploader
  has_many :practice_diaries, dependent: :destroy
  # お気に入り機能のアソシエーション
  has_many :practice_favorites, dependent: :destroy
  # 練習記録コメント機能のアソシエーション
  has_many :practice_comments, dependent: :destroy
  # イベントコメント機能のアソシエーション
  has_many :event_comments, dependent: :destroy
  # フォロー機能のアソシエーション
  has_many :following_friendships, foreign_key: "follower_id", class_name: "Friendship",  dependent: :destroy
  has_many :following, through: :following_friendships
  has_many :follower_friendships, foreign_key: "following_id", class_name: "Friendship", dependent: :destroy
  has_many :followers, through: :follower_friendships
  # イベント機能のアソシエーション
  has_many :events, dependent: :destroy
  # イベント参加機能のアソシエーション
  has_many :participant_managements, dependent: :destroy
  has_many :participant_events, through: :participant_managements, source: :event
  # 通知機能のアソシエーション
  has_many :active_notifications, foreign_key: "visitor_id", class_name: "Notification", dependent: :destroy
  has_many :passive_notifications, foreign_key: "visited_id", class_name: "Notification", dependent: :destroy

  #フォローしているかを確認するメソッド
  def following?(user)
    following_friendships.find_by(following_id: user.id)
  end

  #フォローするときのメソッド
  def follow(user)
    following_friendships.create!(following_id: user.id)
  end

  #フォローを外すときのメソッド
  def unfollow(user)
    following_friendships.find_by(following_id: user.id).destroy
  end

  #ゲストログイン用
  def self.guest
    find_or_create_by!(email: 'guest@example.com', user_name: 'guest') do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  end

  # 本日以前のイベントは表示せず、開催日時が近いイベント順に表示
  scope :recent, -> { where('event_date >= ?', Date.today ).order(event_date: :asc) }

  # フォロー通知機能
  def create_notification_follow!(current_user)
    #すでに通知が作成されているか確認
    temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ? ",current_user.id, id, 'follow'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
end
end
