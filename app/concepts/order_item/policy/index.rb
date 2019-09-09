class OrderItem::Policy::IndexGuard
  include Uber::Callable

  def call(_ctx, params:, **)
    params[:order_id].to_i == params[:current_order]&.id
  end
end
