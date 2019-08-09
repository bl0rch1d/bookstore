FactoryBot.define do
  factory :order do
    user
    state { I18n.t('order.filter').values.sample }

    trait :with_order_items do
      order_items { create_list(:order_item, 5) }
    end

    trait :at_shipping_step do
      order_items { create_list(:order_item, 5) }

      billing_address { create :billing_address, :for_order }
      shipping_address { create :shipping_address, :for_order }

      shipping_method_id { create(:shipping_method).id }
    end

    trait :at_payment_step do
      order_items { create_list(:order_item, 5) }

      billing_address { create :billing_address, :for_order }
      shipping_address { create :shipping_address, :for_order }

      shipping_method_id { create(:shipping_method).id }

      credit_card { create :credit_card }
    end

    trait :full do
      order_items { create_list(:order_item, 5) }

      billing_address { create :billing_address, :for_order }
      shipping_address { create :shipping_address, :for_order }

      credit_card { create :credit_card }

      shipping_method_id { create(:shipping_method).id }

      number { 'R' + Array.new(6) { rand(1..9) }.join }
    end
  end
end
