SHIPPING_METHODS_COUNT = 3

SHIPPING_METHODS_COUNT.times do
  ShippingMethod.create! do |method|
    method.title    = FFaker::CheesyLingo.unique.title
    method.min_days = rand(1..5)
    method.max_days = rand(6..20)
    method.price    = rand(1.0..50.0).round(1)
  end
end
