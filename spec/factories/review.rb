FactoryBot.define do
  factory :review do
    title { FFaker::Book.title }
    body { FFaker::HipsterIpsum.words(rand(5..30)).join(' ') }
    rating { rand(1..5) }
    customer
    book
  end
end
