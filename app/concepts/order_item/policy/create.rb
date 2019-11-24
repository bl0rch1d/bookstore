class OrderItem::Policy::CreateGuard
  include Uber::Callable

  def call(_ctx, params:, **)
    current_order = params[:current_order]
    order_id = params[:order_id]
    books_id = params.dig(:order_item, :book_id)

    user_legit?(current_order, order_id) && book_exists?(books_id)
  end

  private

  def user_legit?(current_order, order_id)
    current_order.id == order_id.to_i
  end

  def book_exists?(id)
    Book.exists?(id)
  end
end
