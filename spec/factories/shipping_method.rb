FactoryBot.define do
  factory :shipping_method do
    title { FFaker::CheesyLingo.unique.title }
    min_days { rand(1..5) }
    max_days { rand(6..20) }
    price { rand(1.0..50.0).round(1) }
  end
end
