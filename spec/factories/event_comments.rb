FactoryBot.define do
  factory :event_comment do
    event_comment_content { "MyText" }
    user { nil }
    event { nil }
  end
end
