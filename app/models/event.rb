class Event < ApplicationRecord
  belongs_to :user

  validates :event_date, presence: true
  # event_dateに本日以前の日程を選択できないようにするバリデーション
  validate :date_not_before_today
  validates :event_title, presence: true, length: { maximum: 100 }
	validates :event_content, presence: true, length: { maximum: 1000 }
  validates :minimum_number_of_participant, presence: true, numericality: { greater_than: 1 }
  validates :address, presence: true, length: { maximum: 50 }

  # ジオコーディング用
  geocoded_by :address
  after_validation :geocode, if: :address_changed?
  # 開催日時が近いイベント順に表示
  scope :recent, -> { order(event_date: :asc) }
  # 本日以前の日程を選択させないようにバリデーションを追加
  def date_not_before_today
    errors.add(:event_date, "は本日以降の日付を選択してください") if event_date.nil? || event_date < Date.today
  end
end
