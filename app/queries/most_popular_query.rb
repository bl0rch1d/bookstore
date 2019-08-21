class MostPopularQuery
  def initialize(books)
    @books = books
  end

  def call
    @books.left_outer_joins(:order_items).group(:id).order('count(order_items.id) desc')
  end
end
