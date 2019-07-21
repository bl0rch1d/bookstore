FactoryBot.define do
  factory :coupon do
    code { Array.new(6) { rand(65..90).chr }.join }
    discount { rand(0.01..0.90).round(2) }
    expire_date { Time.zone.at(Time.now.to_i * rand(1.0001..1.009)) }
  end
end
