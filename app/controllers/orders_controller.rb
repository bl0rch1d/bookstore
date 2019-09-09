class OrdersController < ApplicationController
  def index
    result = Order::Index.call(params.merge(current_user: current_user))

    authorize!(result)

    @orders = OrderDecorator.decorate_collection(result['model'])
  end

  def show
    result = Order::Show.call(params.merge(current_user: current_user))

    authorize!(result)

    @order = result['model'].decorate
  end
end
