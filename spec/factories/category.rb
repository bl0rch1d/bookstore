FactoryBot.define do
  factory :category do
    title { FFaker::Food.herb_or_spice }

    trait :with_books do
      after(:create) do |category|
        create_list(:book, 5, :with_many_images, category: category)
      end
    end
  end
end
