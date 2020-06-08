FactoryBot.define do
  factory :user do
    user_name { "test_1" }
    sequence(:email) { |n| "test#{n}@example.com" }
    password { "password" }
    password_confirmation { 'password' }
  end

  factory :user_2, class: User do
    user_name { "test_2" }
    email { "unique@example.com" }
    password { "password" }
    password_confirmation { 'password' }
  end

  factory :user_3, class: User do
    user_name { "test_3" }
    email { "uniquetest@example.com" }
    password { "password" }
    password_confirmation { 'password' }
  end

  factory :user_4, class: User do
    user_name { "test_4" }
    email { "editdeletetest@example.com" }
    password { "password" }
    password_confirmation { 'password' }
  end

  factory :sample_user, class: User do
    user_name { "sample_user" }
    email { "sample_user@example.com" }
    password { "password" }
    password_confirmation { 'password' }
  end
end
