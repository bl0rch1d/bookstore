FactoryBot.define do
  factory :shipping_address do
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    address { FFaker::AddressUS.street_address }
    city { FFaker::AddressUS.city }
    zip { FFaker::AddressUS.zip_code }
    country { FFaker::AddressUS.country }
    phone { FFaker::PhoneNumberNL.international_mobile_phone_number.gsub!(/\s+/, '') }
    type { 'ShippingAddress' }
    association :addressable, factory: :customer
  end
end
