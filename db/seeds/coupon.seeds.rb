COUPONS_COUNT = 5
COUPON_DISCOUNT_RANGE    = (0.01..0.90).freeze

COUPONS_COUNT.times do
  Coupon.create! do |coupon|
    coupon.code         = Array.new(6) { rand(65..90).chr }.join
    coupon.discount     = rand(COUPON_DISCOUNT_RANGE).round(2)
    coupon.used         = false
  end
end
