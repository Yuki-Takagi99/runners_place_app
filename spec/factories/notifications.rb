FactoryBot.define do
  factory :notification do
    visitor { nil }
    visited { nil }
    practice_diary { nil }
    practice_comment { nil }
    action { "MyString" }
    checked { false }
  end
end
