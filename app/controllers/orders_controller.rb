class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    result = Order::Index.call(params, 'current_user' => current_user)

    return redirect_to(orders_path(sort_by: I18n.t('order.filter.in_progress'))) unless result.success?

    @orders = result['model']
  end

  def show
    result = Order::Show.call(params, 'current_user' => current_user)

    return redirect_to(orders_path(sort_by: I18n.t('order.filter.in_progress'))) unless result.success?

    @order = result['model']
  end
end
