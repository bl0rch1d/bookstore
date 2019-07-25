class OrderItem::Policy::IndexGuard
  include Uber::Callable

  def call(_ctx, params:, **)
    params[:order].present? && params[:order].is_a?(Order)
  end
end
