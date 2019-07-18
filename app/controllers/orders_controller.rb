class OrdersController < ApplicationController
  def index
    @current_sorting = params[:sort_by] || 'in progress'

    @orders = Order::Index.call(params, 'customer' => current_customer)['model']
  end

  def show
    @order = Order::Show.call(id: params[:id])['model']
  end
end
