class BestSellersQuery
  def initialize(categories)
    @categories = categories
    @ids = []
  end

  def call
    query_ids

    Book.where(id: @ids).order('category_id asc')
  end

  private

  def query_ids
    @categories.find_each do |category|
      order_item = OrderItem
                   .includes(:book)
                   .where(order: Order.delivered, book: Book.where(category: category))
                   .order('quantity desc')
                   .first

      @ids << (order_item&.book&.id || category.books.first.id)
    end
  end
end
