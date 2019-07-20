class OrdersController < ApplicationController
  before_action :authenticate_customer!

  def index
    @current_sorting = params[:sort_by] || I18n.t('order.states.in_progress')

    @orders = Order::Index.call(params, 'customer' => current_customer)['model']
  end

  def show
    @order = Order::Show.call(id: params[:id])['model']
  end
end
