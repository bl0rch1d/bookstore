FactoryBot.define do
  factory :shipping_address do
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    address_line { FFaker::AddressUS.street_address }
    city { FFaker::AddressUS.city }
    zip { FFaker::AddressUS.zip_code }
    country { FFaker::AddressUS.country }
    phone { FFaker::PhoneNumberNL.international_mobile_phone_number.gsub!(/\s+/, '') }
    type { :ShippingAddress }

    trait :for_user do
      addressable { create :user }
    end

    trait :for_order do
      addressable { create :order }
    end
  end

  factory :billing_address do
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    address_line { FFaker::AddressUS.street_address }
    city { FFaker::AddressUS.city }
    zip { FFaker::AddressUS.zip_code }
    country { FFaker::AddressUS.country }
    phone { FFaker::PhoneNumberNL.international_mobile_phone_number.gsub!(/\s+/, '') }
    type { :BillingAddress }

    trait :for_user do
      addressable { create :user }
    end

    trait :for_order do
      addressable { create :order }
    end
  end
end
