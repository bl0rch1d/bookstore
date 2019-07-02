class ShippingMethod < ApplicationRecord
  has_many :orders

  validates :title, :min_days, :max_days, :price, presence: true
  validates :price, numericality: { greater_or_equal_to: 0, less_than_or_equal_to: 100_000 }
end
