FactoryBot.define do
  factory :user do
    email { FFaker::Internet.email }
    password { FFaker::Internet.password + rand(1..9).to_s }
    confirmed_at { Time.zone.now }

    trait :with_addresses do
      shipping_address { create :shipping_address, :for_user }
      billing_address { create :billing_address, :for_user }
    end

    trait :with_orders do
      orders { create_list(:order, 20, completed_at: Time.zone.now) }
    end
  end
end
