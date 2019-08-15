class ShippingMethod < ApplicationRecord
  TITLE_LENGTH = 50

  MIN_PRICE    = 0
  MAX_PRICE    = 150

  has_many :orders, dependent: :destroy

  validates :title, :min_days, :max_days, :price, presence: true
  validates :title, uniqueness: true, length: { maximum: TITLE_LENGTH }
  validates :price, numericality: { greater_than_or_equal_to: MIN_PRICE, less_than_or_equal_to: MAX_PRICE }
end
