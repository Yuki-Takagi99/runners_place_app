class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  mount_uploader :image, ImageUploader
  has_many :practice_diaries
  # お気に入り機能のアソシエーション
  has_many :practice_favorites, dependent: :destroy
  # コメント機能のアソシエーション
  has_many :practice_comments, dependent: :destroy
  # Userモデルのバリデーション
  validates :user_name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, uniqueness: true

  # フォロー機能のアソシエーション
  has_many :following_friendships, foreign_key: "follower_id", class_name: "Friendship",  dependent: :destroy
  has_many :following, through: :following_friendships
  has_many :follower_friendships, foreign_key: "following_id", class_name: "Friendship", dependent: :destroy
  has_many :followers, through: :follower_friendships

  # イベント機能のアソシエーション
  has_many :events, dependent: :destroy
  # イベント参加機能のアソシエーション
  has_many :participant_managements, dependent: :destroy

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
end
