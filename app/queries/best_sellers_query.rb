class BestSellersQuery
  def initialize(categories)
    @categories = categories
  end

  def call
    Book.where(id: bestsellers_ids).order('category_id asc')
  end

  def bestsellers_ids
    @categories.map do |category|
      order_items_books = OrderItem.includes(:book)
                                   .where(order: Order.delivered, book: Book.where(category: category))
                                   .group_by(&:book)

      total_quantity = order_items_books.map { |book, item| [book, item.sum(&:quantity)] }

      (total_quantity.sort_by(&:second).reverse.dig(0, 0) || category.books.first).id
    end
  end
end
