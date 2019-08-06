class OrderItem::Create < Trailblazer::Operation
  step Policy::Guard(OrderItem::Policy::CreateGuard.new), fail_fast: true
  step :model
  step Contract::Build(constant: OrderItem::Contract::Create)
  success :quantity
  success :price_and_subtotal
  step Contract::Validate(key: :order_item), fail_fast: true
  step Contract::Persist()

  def model(ctx, params:, **)
    ctx['model'] = OrderItem.find_or_create_by(
      order_id: params[:order_item][:order_id],
      book_id: params[:order_item][:book_id]
    )
  end

  def quantity(ctx, params:, **)
    params[:order_item][:quantity] = (ctx['model'].quantity || 0) + params[:order_item][:quantity].to_f
  end

  def price_and_subtotal(_ctx, params:, **)
    params[:order_item][:price]    = Book.find_by(id: params[:order_item][:book_id]).price
    params[:order_item][:subtotal] = params[:order_item][:price] * params[:order_item][:quantity]
  end
end
