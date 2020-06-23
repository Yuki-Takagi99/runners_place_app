15.times do |n|
  User.create!(
    email: "run#{n + 1}@test.com",
    user_name: "ラン太郎#{n + 1}",
    self_introduction: "マラソン完走#{n + 1}回の市民ランナーです。",
    target: "今年は#{n + 2}回目のマラソン完走と自己ベスト更新を目指します！",
    password: "running#{n + 1}"
  )
end

User.create!(
  email: "admin@test.com",
  user_name: "管理者",
  self_introduction: "管理者ユーザです。",
  target: "管理者ユーザです。",
  password: "adminadmin",
  admin: 'true'
)

User.all.each do |user|
  user.practice_diaries.create!(
    practice_date: Date.today - 1,
    practice_title: 'ジョギング',
    practice_content: '会社の仲間と皇居の周りを10km走りました！いい汗かいた！',
    practice_distance: '10.0',
    practice_time: '1:00:00'
  )
end

User.all.each do |user|
  user.events.create!(
    event_date: Date.today + 7,
    event_title: '定期練習会',
    event_content: "全員でストレッチのあと、各々の走力を考慮し、15kmランを実施します。\nその後有志にて懇親会を行います。最近走り始めた方、ベテランランナーの方、どなたでも大歓迎です。\nラン仲間をお探しの方、お待ちしております。\n私は正門前で黄色のウインドブレーカーを着ていますのでお声がけ下さい。",
    minimum_number_of_participant: '3',
    address: '井の頭公園'
  )
end