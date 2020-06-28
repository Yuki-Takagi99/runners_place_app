module ApplicationHelper
  # practice_timeがtime型のため、下記メソッド定義
  # タイムゾーン設定はUTCのため,投稿日時などを表示する際にlocalize_helperでtime_zone設定を'Asia,Tokyo'に変更する
  def localize_helper(time, zone)
    I18n.l time.in_time_zone(zone)
  end

  # 1kmあたりのペースを計算
  def pace_cal_helper(practice_time, practice_distance)
    # practice_timeを配列に変換。秒 分 時 日 月 年 曜日 年内通算日 夏時間? タイムゾーンの順
    time_arr = practice_time.to_a
    # practice_distanceを変数に代入
    distance = practice_distance
    # 時間、分、秒をそれぞれ変数に代入しfloatに変換
    hour = time_arr[2]
    min = time_arr[1]
    sec = time_arr[0]
    # 時間、分をそれぞれ秒に変換し秒の合計を出す
    hour_change_min = 60 * hour
    hour_change_sec = hour_change_min * 60
    min_change_sec = min * 60
    total_sec = hour_change_sec + min_change_sec + sec
    # 合計をfloat型に変換しpractice_distanceで割る
    km_sec = total_sec.to_f / distance
    # 秒の合計を00:00:00の形に変換して出力
    p Time.at(km_sec.to_i).utc.strftime('%X')
  end
end
