class OrderDecorator < Draper::Decorator
  delegate_all

  def subtotal
    order_items.inject(0) { |sum, item| sum + (item.book.price * item.quantity) }
  end

  def total
    price = coupon ? subtotal - coupon.calculate_in_fact_discount(subtotal) : subtotal

    shipping_method_id ? price + ShippingMethod.find(shipping_method_id).price : price
  end

  def generate_number
    'R' + Array.new(6) { rand(1..9) }.join
  end
end
