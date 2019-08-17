class OrdersController < ApplicationController
  execute_and_authorize_operation

  def index
    @orders = OrderDecorator.decorate_collection(@operation_result['model'])
  end

  def show
    @order = @operation_result['model'].decorate
  end
end
