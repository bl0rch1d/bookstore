FactoryBot.define do
  factory :category do
    title { ['Mobile development', 'Photo', 'Web design', 'Web development'].sample }
  end
end
