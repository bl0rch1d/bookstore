module OrderItem::Contract
  class Create < Reform::Form
    MIN_COUNT = 1
    MAX_COUNT = 10

    property :quantity
    property :book_id
    property :order_id

    validates :quantity, numericality: { greater_or_equal_to: MIN_COUNT, less_than_or_equal_to: MAX_COUNT }
  end
end
