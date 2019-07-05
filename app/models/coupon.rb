class Coupon < ApplicationRecord
  belongs_to :order, optional: true

  # === TODO: Constant ===
  validates :code, :discount, :expire_date, presence: true
  validates :discount, numericality: { only_integer: true, less_than: 100, greater_than: 1 }

  # === TODO: Decorator ===
  def format_discount
    discount.to_s + '%'
  end
end
