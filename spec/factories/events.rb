FactoryBot.define do
  factory :event do
    event_date { "2020-06-14 11:29:02" }
    event_title { "MyString" }
    event_content { "MyText" }
    minimum_number_of_participant { 1 }
    address { "国立競技場" }
    latitude { 1.5 }
    longitude { 1.5 }
    user_id { 1 }
  end
end
