FactoryBot.define do
  factory :event do
    event_date { Date.today + 1 }
    event_title { "MyString" }
    event_content { "MyText" }
    minimum_number_of_participant { 1 }
    address { "国立競技場" }
    user_id { 1 }
  end
end
