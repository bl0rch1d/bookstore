class OrderItem::Create < Trailblazer::Operation
  step Policy::Guard(OrderItem::Policy::CreateGuard.new), fail_fast: true
  step :model
  step Contract::Build(constant: OrderItem::Contract::Create)
  step :define_quantity
  success :calculate_price
  step :validate, fail_fast: true
  step Contract::Persist()

  def model(ctx, params:, **)
    ctx['model'] = OrderItem.find_or_create_by(order_id: params[:order_id], book_id: params[:book_id])
  end

  def define_quantity(_ctx, model:, params:, **)
    quantity = model.quantity ? model.quantity + (params[:quantity] || 1) : (params.dig(:order_item, :quantity) || 1)

    model.quantity = quantity.to_f
  end

  def calculate_price(ctx, params:, **)
    ctx['model'].price      = Book.find_by(id: params[:book_id]).price
    ctx['model'].subtotal   = ctx['model'].price * ctx['model'].quantity
  end

  def validate(ctx, params:, **)
    ctx['contract.default'].validate(ctx['model'].attributes)
  end
end
