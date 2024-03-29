FactoryBot.define do
  factory :coupon do
    code { Array.new(6) { ('A'..'Z').to_a.sample }.join }
    discount { rand(0.01..0.90).round(2) }
    used { false }
  end
end
