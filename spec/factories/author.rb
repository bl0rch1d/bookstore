FactoryBot.define do
  factory :author do
    sequence :first_name do |n|
      "#{FFaker::Name.first_name}#{n}"
    end

    last_name { FFaker::Name.last_name }
  end
end
