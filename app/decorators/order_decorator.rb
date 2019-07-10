class OrderDecorator < Draper::Decorator
  delegate_all

  def subtotal
    order_items.inject(0) { |sum, item| sum + (item.book.price * item.quantity) }
  end

  def total
    coupon ? subtotal - coupon.calculate_in_fact_discount(subtotal) : subtotal
  end

  def number
    'R' + Array.new(6) { rand(1..9) }.join
  end
end
