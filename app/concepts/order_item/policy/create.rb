class OrderItem::Policy::CreateGuard
  include Uber::Callable

  def call(_ctx, params:, **)
    Book.exists?(params[:book_id]) && Order.exists?(params[:order_id])
  end
end
