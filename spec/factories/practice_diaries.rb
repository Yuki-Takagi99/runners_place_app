FactoryBot.define do
  factory :practice_diary do
    practice_title { "test_title" }
    practice_content { "test_content" }
    practice_distance { 10.0 } 
    practice_time { Time.now }
  end
end