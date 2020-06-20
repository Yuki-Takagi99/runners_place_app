FactoryBot.define do
  factory :event do
    event_date { Date.today + 7 }
    event_title { "定期練習会" }
    event_content { "みんなで10km走ります。" }
    minimum_number_of_participant { 2 }
    address { "国立競技場" }
  end
end
