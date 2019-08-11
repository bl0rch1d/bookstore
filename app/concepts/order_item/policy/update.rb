class OrderItem::Policy::UpdateGuard
  include Uber::Callable

  def call(_ctx, params:, **)
    params[:current_order].id == params[:order_id].to_i &&
      params[:current_order].order_items.ids.include?(params[:id].to_i)
  end
end
