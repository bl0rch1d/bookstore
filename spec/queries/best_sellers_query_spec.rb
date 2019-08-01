# class BestSellersQuery
#   def initialize(categories)
#     @categories = categories
#   end

#   def call
#     @categories.map do |category|
#       order_items_books = OrderItem.includes(:book)
#                                    .where(order: Order.delivered, book: Book.where(category: category))
#                                    .group_by(&:book)

#       total_quantity = order_items_books.map { |book, item| [book, item.sum(&:quantity)] }

#       total_quantity.sort_by(&:second).reverse.dig(0, 0) || category.books.first
#     end
#   end
# end

# === TODO: Refactor ===
RSpec.describe BestSellersQuery do
  let(:result) { described_class.new(Category.all).call }

  context 'when correct query result' do
    # 4.times do
    #   it 'works' do
    #     Book.find_each(&:destroy!) if Book.all.any?

    #     category_coff = rand(4..10)
    #     coff = rand(5..10)

    #     create_list(:category, category_coff)
    #     Category.all.each { |category| create_list(:book, coff, category: category) }
    #     create_list(:order_item, coff * category_coff, book: Book.all.sample)

    #     expect(result.size).to be(Category.all.size)
    #     expect(result.sample).to be_a(Book)
    #   end
    # end
  end
end
