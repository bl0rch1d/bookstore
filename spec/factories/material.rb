FactoryBot.define do
  factory :material do
    title { ['glossy paper', 'hardcover', 'soft paper', 'cardboard'].sample }
  end
end
