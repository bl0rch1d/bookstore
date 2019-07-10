class ShippingMethod < ApplicationRecord
  has_many :orders, dependent: :destroy

  validates :title, :min_days, :max_days, :price, presence: true
  validates :title, uniqueness: true, length: { maximum: MAX_TITLE_LENGTH }
  validates :price, numericality: { greater_or_equal_to: MIN_PRICE, less_than_or_equal_to: MAX_PRICE }
end
