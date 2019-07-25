FactoryBot.define do
  factory :credit_card do
    card_name { FFaker::Name.first_name }
    number { Array.new(16) { rand(1..9) }.join }
    cvv { Array.new(rand(3..4)) { rand(1..9) }.join }
    expiration_date { "0#{rand(1..9)}/0#{rand(1..9)}" }
    order
  end
end
