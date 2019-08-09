describe CouponDecorator do
  subject(:coupon) { create(:coupon).decorate }

  it '#format_discount' do
    expect(coupon.format_discount).to eq((coupon.discount * 100).to_s.split('.')[0] + '%')
  end

  it '#calculated_discount' do
    create :order, coupon: coupon

    expect(coupon.calculated_discount).to eq((coupon.discount * Order.last.decorate.subtotal).round(2))
  end
end
