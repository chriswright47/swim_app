# Read about factories at https://github.com/thoughtbot/factory_girl
require 'faker'

FactoryGirl.define do
  factory :team do
    name Faker::Lorem.words[0]
    mascot Faker::Lorem.words[0]
  end
end
