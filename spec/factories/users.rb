FactoryBot.define do
  sequence :email do |n|
    "user#{n}@test.com"
  end
  factory :user do
    nickname "Willy"
    email
    password '123456'
  end
end