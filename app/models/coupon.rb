class Coupon < ApplicationRecord
  belongs_to :order, optional: true

  MIN_DISCOUNT = 0.05
  MAX_DISCOUNT = 0.90

  validates :code, :discount, :expire_date, presence: true
  validates :discount, numericality: { greater_or_equal_to: MIN_DISCOUNT, less_than_or_equal_to: MAX_DISCOUNT }

  def calculate_in_fact_discount(price)
    (discount * price).round(2)
  end

  def expired?
    Time.now.to_i > expire_date.to_i
  end
end
