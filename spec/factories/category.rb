FactoryBot.define do
  factory :category do
    sequence(:title) { |n| "#{FFaker::Lorem.word}#{n}" }

    trait :with_books do
      after(:create) do |category|
        create_list(:book, 5, category: category)
      end
    end
  end
end
