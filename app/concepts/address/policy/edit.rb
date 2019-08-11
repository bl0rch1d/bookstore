class Address::Policy::EditGuard
  include Uber::Callable

  def call(_ctx, params:, **)
    params[:current_user].present?
  end
end
