class Order::Policy::ShowGuard
  include Uber::Callable

  def call(_ctx, params:, **)
    params[:current_user]&.id == params[:user_id].to_i &&
      Order.find_by(id: params[:id])&.user_id == params[:current_user].id
  end
end
