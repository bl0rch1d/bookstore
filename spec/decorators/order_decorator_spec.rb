describe OrderDecorator do
  subject(:order) { create(:order, :at_complete_step).decorate }

  it '#decorates coupon' do
    create :coupon, order: order

    expect(order.coupon).to respond_to(:format_discount)
  end

  it '#decorates credit_card' do
    expect(order.credit_card).to respond_to(:secure_number)
  end

  it '#decorates billing_address' do
    expect(order.billing_address).to respond_to(:full_name)
  end

  it '#decorates shipping_address' do
    expect(order.shipping_address).to respond_to(:city_zip)
  end

  it '#subtotal' do
    expect(order.subtotal).to eq(order.order_items.inject(0) { |sum, item| sum + (item.book.price * item.quantity) })
  end

  it '#total' do
    price = order.coupon ? order.subtotal - order.coupon.calculated_discount : order.subtotal
    total = order.shipping_method ? price + order.shipping_method.price : price

    expect(order.total).to eq(total)
  end

  it '#generate_number' do
    expect(order.generate_number).to match(/\AR\d+\z/)
  end
end
