class CheckoutStep::Policy::CheckoutGuard
  include Uber::Callable

  def call(_ctx, params:, **)
    params[:current_order].order_items.any?
  end
end
