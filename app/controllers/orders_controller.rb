class OrdersController < ApplicationController
  def index
    @current_sorting = params[:sort_by] || 'in progress'

    @orders = OrdersSortingQuery.new(current_customer, params).call
  end

  def show
    @order = Order.find(params[:id])
  end
end
