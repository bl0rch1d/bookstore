FactoryBot.define do
  factory :material do
    title { Array.new(8) { rand(65..90).chr }.join }
  end
end
