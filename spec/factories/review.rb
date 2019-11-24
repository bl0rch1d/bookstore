FactoryBot.define do
  factory :review do
    title { FFaker::Book.title }
    body { FFaker::HipsterIpsum.words(rand(5..30)).join(' ') }
    rating { rand(1..5) }
    user_id { create(:user, :with_addresses).id }
    book_id { create(:book).id }
  end
end
