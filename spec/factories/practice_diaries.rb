FactoryBot.define do
  factory :practice_diary do
    practice_title { "テストタイトル" }
    practice_content { "テストコンテンツ" }
    practice_distance { 10.0 } 
    practice_time { Time.now }
  end
end