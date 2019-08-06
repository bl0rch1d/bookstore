module OrderItem::Contract
  class Create < Reform::Form
    property :quantity
    property :price
    property :subtotal

    property :book_id
    property :order_id

    validates :quantity, numericality: {
      greater_than_or_equal_to: Book::MIN_QUANTITY + 1,
      less_than_or_equal_to: Book::MAX_QUANTITY
    }

    validates :price, :subtotal, numericality: {
      greater_than_or_equal_to: ApplicationRecord::MIN_PRICE,
      less_than_or_equal_to: ApplicationRecord::MAX_PRICE
    }
  end
end
