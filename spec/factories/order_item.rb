FactoryBot.define do
  factory :order_item do
    price { rand(10.0..200.0).round(1) }
    quantity { rand(2..10) }
    subtotal { price * quantity.to_f }
    order
    book
  end
end
