require 'faker'

FactoryGirl.define do
  factory :user do
    first_name {Faker::Name.first_name}
    last_name {Faker::Name.last_name}
    sequence(:email) { |n| "user#{n}@factory.com" }
    password 'password'
    password_confirmation 'password'
    association :team
  end
end