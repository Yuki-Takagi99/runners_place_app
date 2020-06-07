FactoryBot.define do
  factory :user do
    user_name { "test_1" }
    sequence(:email) { |n| "test#{n}@example.com" }
    password { "password" }
    password_confirmation { 'password' }
  end

  factory :user_2, class: User do
    user_name { "test_1" }
    email { "unique@example.com" }
    password { "password" }
    password_confirmation { 'password' }
  end

  factory :user_3, class: User do
    user_name { "test_1" }
    email { "uniquetest@example.com" }
    password { "password" }
    password_confirmation { 'password' }
  end
end
