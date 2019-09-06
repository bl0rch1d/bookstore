FactoryBot.define do
  factory :book do
    sequence(:title) { |n| "#{FFaker::Lorem.word}#{n}" }

    description { FFaker::Book.description }
    price { rand(5.0..200.00).round(2) }
    quantity { rand(10..50) }
    height { rand(1.0..10.0).round(1) }
    width { rand(1.0..10.0).round(1) }
    depth { rand(1.0..10.0).round(1) }
    year { rand(1850..2019) }
    category
    authors { Array.new(rand(1..3)) { create(:author) } }
    materials { create_list(:material, rand(1..4)) }

    trait :with_many_images do
      after :create do |book|
        4.times do
          book.images.attach(
            io: File.open(Rails.root.join("spec/fixtures/books/#{rand(1..4)}.jpg")),
            filename: 'cover.jpg',
            content_type: 'image/jpg'
          )
        end
      end
    end

    trait :with_random_images_count do
      after :create do |book|
        rand(0..4).times do
          book.images.attach(
            io: File.open(Rails.root.join("spec/fixtures/books/#{rand(1..4)}.jpg")),
            filename: 'cover.jpg',
            content_type: 'image/jpg'
          )
        end
      end
    end
  end
end
