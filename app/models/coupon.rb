class Coupon < ApplicationRecord
  MIN_DISCOUNT = 0.01
  MAX_DISCOUNT = 0.90

  belongs_to :order, optional: true

  validates :code, :discount, :expire_date, presence: true
  validates :discount, numericality: { greater_than_or_equal_to: MIN_DISCOUNT, less_than_or_equal_to: MAX_DISCOUNT }
end
