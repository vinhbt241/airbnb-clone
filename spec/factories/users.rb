FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { "passwordtest123" }
    confirmed_at { 1.day.ago }
  end
end
