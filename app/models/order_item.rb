class OrderItem < ApplicationRecord
  belongs_to :order, optional: true
  belongs_to :book

  MIN_COUNT = 1
  MAX_COUNT = 10

  validates :quantity, numericality: { greater_or_equal_to: MIN_COUNT, less_than_or_equal_to: MAX_COUNT }
end
