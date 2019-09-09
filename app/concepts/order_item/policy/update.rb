class OrderItem::Policy::UpdateGuard
  include Uber::Callable

  def call(_ctx, params:, **)
    current_order = params[:current_order]
    order_id = params[:order_id]
    order_item_id = params[:id]

    user_legit?(current_order, order_id) && items_exists?(current_order, order_item_id)
  end

  private

  def user_legit?(current_order, order_id)
    current_order.id == order_id.to_i
  end

  def items_exists?(current_order, item_id)
    current_order.order_items.exists?(item_id)
  end
end
