require 'rails_helper'

RSpec.describe CouponDecorator do
  subject(:coupon) { create(:coupon).decorate }

  it '#format_discount' do
    expect(coupon.format_discount).to eq((coupon.discount * 100).to_s.split('.')[0] + '%')
  end
end
