FactoryBot.define do
  factory :credit_card do
    card_name { FFaker::Address.first_name }
    number { Array.new(16) { rand(1..9) }.join }
    cvv { Array.new(rand(3..4)) { rand(1..9) }.join }
    expiration_date { "#{rand(1..12)}/#{rand(1..28)}" }
  end
end
