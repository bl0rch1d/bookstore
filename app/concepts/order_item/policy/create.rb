class OrderItem::Policy::CreateGuard
  include Uber::Callable

  def call(_ctx, params:, **)
    params[:current_order].id == params[:order_id].to_i &&
      Book.exists?(params.dig(:order_item, :book_id))
  end
end
