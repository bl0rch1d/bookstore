class OrderDecorator < Draper::Decorator
  delegate_all

  decorates_association :coupon
  decorates_association :credit_card
  decorates_association :billing_address
  decorates_association :shipping_address

  def subtotal
    order_items.inject(0) { |sum, item| sum + (item.book.price * item.quantity) }
  end

  def total
    price = coupon ? subtotal - coupon.calculated_discount : subtotal

    shipping_method_id ? price + ShippingMethod.find(shipping_method_id).price : price
  end

  def generate_number
    'R' + Array.new(6) { rand(1..9) }.join
  end
end
