FactoryBot.define do
  factory :user do
    id { 1 }
    user_name { "test_1" }
    sequence(:email) { |n| "test#{n}@example.com" }
    password { "password" }
    password_confirmation { 'password' }
  end

  factory :jon, class: User do
    id { 2 }
    user_name { "jon" }
    email { "jon@example.com" }
    password { "password" }
    password_confirmation { 'password' }
  end

  factory :bob, class: User do
    user_name { "bob" }
    email { "bob@example.com" }
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
