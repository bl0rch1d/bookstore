FactoryBot.define do
  factory :category do
    title { FFaker::Food.herb_or_spice }
  end
end
