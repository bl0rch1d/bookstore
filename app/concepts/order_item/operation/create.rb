class OrderItem::Create < Trailblazer::Operation
  step :model
  step Contract::Build(constant: OrderItem::Contract::Create)
  success :set_attributes
  step :validate, fail_fast: true
  step Contract::Persist()

  def model(ctx, params:, **)
    ctx['model'] = OrderItem.find_or_create_by(order_id: params[:order_id], book_id: params[:book_id])
  end

  def set_attributes(_ctx, model:, params:, **)
    quantity = model.quantity ? model.quantity + (params[:quantity] || 1) : (params.dig(:order_item, :quantity) || 1)

    model.quantity   = quantity.to_f
    model.price      = Book.find_by(id: params[:book_id]).price
    model.subtotal   = model.price * quantity.to_f
  end

  def validate(ctx, params:, **)
    ctx['contract.default'].validate(ctx['model'].attributes)
  end
end
