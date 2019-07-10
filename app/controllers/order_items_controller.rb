class OrderItemsController < ApplicationController
  
  # === TODO: Service objects ===
  def create
    session[:current_order_id] = current_order.id

    book = Book.find_by(id: params[:book_id])
    order_item = OrderItem.find_or_create_by(order_id: current_order.id, book_id: book.id)

    quantity = order_item.quantity || 0

    new_quantity = params.dig(:order_item, :quantity)&.to_i || 1

    order_item.quantity   = quantity + new_quantity
    order_item.price      = book.price
    order_item.subtotal   = order_item.quantity.to_f * book.price

    if order_item.save
      redirect_back(fallback_location: root_path, notice: 'Item has been added to cart')
    else
      redirect_back(fallback_location: root_path, alert: order_item.errors)
    end
  end

  def update
    order_item = OrderItem.find(params[:id])

    old_price_per_unit = order_item.price

    order_item.quantity = order_item.quantity + params[:quantity].to_i

    order_item.subtotal = old_price_per_unit * order_item.quantity.to_f

    if order_item.save
      redirect_back(fallback_location: root_path, notice: 'Item has been updated')
    else
      redirect_back(fallback_location: root_path, alert: order_item.errors)
    end
  end

  def destroy
    order_item = OrderItem.find(params[:id])

    if order_item.destroy
      current_order.total_price = order_item.subtotal
      redirect_back(fallback_location: root_path, notice: 'Item has been removed')
    else
      redirect_back(fallback_location: root_path, alert: order_item.errors)
    end
  end
end
