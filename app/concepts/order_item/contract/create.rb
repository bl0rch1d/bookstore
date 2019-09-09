module OrderItem::Contract
  class Create < Reform::Form
    MIN_PRICE = 0
    MAX_PRICE = 100_000

    MIN_QUANTITY = 1
    MAX_QUANTITY = 100

    property :quantity
    property :price
    property :subtotal

    property :book_id
    property :order_id

    validates :quantity, numericality: {
      greater_than_or_equal_to: MIN_QUANTITY,
      less_than_or_equal_to: MAX_QUANTITY
    }

    validates :price, :subtotal, numericality: {
      greater_than_or_equal_to: MIN_PRICE,
      less_than_or_equal_to: MAX_PRICE
    }
  end
end
