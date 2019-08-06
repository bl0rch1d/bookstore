class OrderItem::Policy::CreateGuard
  include Uber::Callable

  def call(_ctx, params:, **)
    Book.exists?(params.dig(:order_item, :book_id)) && Order.exists?(params.dig(:order_item, :order_id))
  end
end
