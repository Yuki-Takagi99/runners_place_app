module ApplicationHelper
  # practice_timeがtime型のため、下記メソッド定義
  # 基本はUTC,投稿日時などを表示する際にlocalizeメソッドでtime_zone設定を'Asia,Tokyo'に変更する
  def localize(time, zone)
    I18n.l time.in_time_zone(zone)
  end
end
