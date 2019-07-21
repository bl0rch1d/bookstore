FactoryBot.define do
  factory :customer do
    email { Faker::Internet.email }
    password { FFaker::Internet.password }
  end
end
