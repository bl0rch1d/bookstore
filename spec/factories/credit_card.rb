FactoryBot.define do
  factory :credit_card do
    number { Array.new(16) { rand(1..9) }.join }
    card_name { FFaker::Name.first_name }
    expiration_date { '10/25' }
    cvv { Array.new(rand(3..4)) { rand(1..9) }.join }
    order_id { create(:order).id }
  end
end
