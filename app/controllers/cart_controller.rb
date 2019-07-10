class CartController < ApplicationController
  def index
    @items = current_order.order_items.order('quantity DESC')
  end
end
