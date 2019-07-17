class CartController < ApplicationController
  def index
    @items = OrderItem::Index.call(order: current_order)['model']
  end
end
