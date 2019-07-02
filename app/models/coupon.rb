class Coupon < ApplicationRecord
  belongs_to :order

  validates :code, :expire_date, presence: true
  validates :discount, numericality: { only_integer: true, less_than: 100, greater_than: 1 }
end
