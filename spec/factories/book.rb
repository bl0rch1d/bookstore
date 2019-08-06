FactoryBot.define do
  factory :book do
    sequence(:title) { |n| "#{FFaker::Lorem.word}#{n}" }

    description { FFaker::Book.description }
    price { rand(5.0..200.00) }
    quantity { rand(10..50) }
    height { rand(1.0..10.0).round(1) }
    width { rand(1.0..10.0).round(1) }
    depth { rand(1.0..10.0).round(1) }
    year { rand(1850..2019) }
    category
    authors { Array.new(3) { create(:author) } }

    after :create do |book|
      book.images.attach(
        io: File.open(Rails.root.join("spec/fixtures/books/#{rand(1..4)}.jpg")),
        filename: 'cover.jpg',
        content_type: 'image/jpg'
      )
    end

    trait :with_many_images do
      after :create do |book|
        3.times do
          book.images.attach(
            io: File.open(Rails.root.join("spec/fixtures/books/#{rand(1..4)}.jpg")),
            filename: 'cover.jpg',
            content_type: 'image/jpg'
          )
        end
      end

      materials { create_list(:material, 2) }
    end
  end
end
