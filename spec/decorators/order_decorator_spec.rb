RSpec.describe OrderDecorator do
  subject(:order) { create(:order).decorate }

  it '#subtotal' do
    expect(order.subtotal).to eq(order.order_items.inject(0) { |sum, item| sum + (item.book.price * item.quantity) })
  end

  it '#total' do
    price = order.coupon ? order.subtotal - order.coupon.calculated_discount : order.subtotal
    order.shipping_method_id ? price + ShippingMethod.find(order.shipping_method_id).price : price

    expect(order.total).to eq(price)
  end

  it '#generate_number' do
    expect(order.generate_number).to match(/\AR\d+\z/)
  end
end
