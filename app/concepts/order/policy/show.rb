class Order::Policy::ShowGuard
  include Uber::Callable

  def call(_ctx, params:, **)
    @params = params

    first_condition? && second_condition?
  end

  private

  def first_condition?
    @params[:current_user]&.id == @params[:user_id].to_i
  end

  def second_condition?
    Order.find_by(id: @params[:id])&.user_id == @params[:current_user].id
  end
end
