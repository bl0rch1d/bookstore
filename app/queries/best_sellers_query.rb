class BestSellersQuery
  def initialize; end

  def call
    books = Order.all.where(state: :delivered).flat_map(&:books)
    books.map { |book| [book, books.count(book)] }.sort_by(&:second).last(4).map(&:first)
  end
end
