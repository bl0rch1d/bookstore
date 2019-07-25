FactoryBot.define do
  factory :material do
    title { FFaker::Food.unique.herb_or_spice }
  end
end
