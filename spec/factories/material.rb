FactoryBot.define do
  factory :material do
    sequence(:title) { |n| "#{FFaker::Lorem.word}#{n}" }
  end
end
