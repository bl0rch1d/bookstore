class OrdersController < ApplicationController
  def index
    @orders = current_customer.orders
  end

  def show; end
end
