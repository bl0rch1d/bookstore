FactoryBot.define do
  factory :order do
    user
    state { I18n.t('order.filter').values.sample }

    trait :at_address_step do
      order_items { create_list(:order_item, 5) }
    end

    trait :at_shipping_step do
      order_items { create_list(:order_item, 5) }

      billing_address { create :billing_address, :for_order }
      shipping_address { create :shipping_address, :for_order }
    end

    trait :at_payment_step do
      order_items { create_list(:order_item, 5) }

      billing_address { create :billing_address, :for_order }
      shipping_address { create :shipping_address, :for_order }

      shipping_method_id { create(:shipping_method).id }
    end

    trait :at_confirm_step do
      order_items { create_list(:order_item, 5) }

      billing_address { create :billing_address, :for_order }
      shipping_address { create :shipping_address, :for_order }

      shipping_method_id { create(:shipping_method).id }

      credit_card { create :credit_card }
    end

    trait :at_complete_step do
      order_items { create_list(:order_item, 5) }

      billing_address { create :billing_address, :for_order }
      shipping_address { create :shipping_address, :for_order }

      shipping_method_id { create(:shipping_method).id }

      credit_card { create :credit_card }

      number { 'R' + Array.new(6) { rand(1..9) }.join }

      completed_at { Time.zone.now }
    end
  end
end
