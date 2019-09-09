class Order::Policy::IndexGuard
  include Uber::Callable

  def call(_ctx, params:, **)
    params[:current_user]&.id == params[:user_id].to_i
  end
end
