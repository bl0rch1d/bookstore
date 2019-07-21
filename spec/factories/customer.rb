FactoryBot.define do
  factory :customer do
    after(:build, &:skip_confirmation_notification!)
    after(:create, &:confirm)

    email { FFaker::Internet.email }
    password { FFaker::Internet.password }

    trait :with_addresses do
      shipping_address { create :shipping_address, :for_customer }
      billing_address { create :billing_address, :for_customer }
    end
  end
end
