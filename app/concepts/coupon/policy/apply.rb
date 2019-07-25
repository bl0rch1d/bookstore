class Coupon::Policy::ApplyGuard
  include Uber::Callable

  def call(_ctx, params:, **)
    params[:order].present? && params[:order].is_a?(Order)
  end
end
