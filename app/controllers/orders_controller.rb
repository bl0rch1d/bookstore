class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @current_sorting = params[:sort_by] || I18n.t('order.states.in_progress')

    @orders = Order::Index.call(params, 'user' => current_user)['model']
  end

  def show
    @order = Order::Show.call(id: params[:id])['model']
  end
end
