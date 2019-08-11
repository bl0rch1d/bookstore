class Checkout::Policy::UserGuard
  include Uber::Callable

  def call(_ctx, params:, **)
    params[:current_order]&.user_id == params[:current_user].id
  end
end
