class OrderItem::Update < Trailblazer::Operation
  step Model(OrderItem, :find_by), fail_fast: true
  step Contract::Build(constant: OrderItem::Contract::Create)
  success :update_attributes
  step :validate, fail_fast: true
  step Contract::Persist()

  def update_attributes(ctx, params:, **)
    quantity = ctx['model'].quantity + (params[:quantity] || 1).to_f

    subtotal = ctx['model'].price * quantity

    ctx['model'].quantity = quantity
    ctx['model'].subtotal = subtotal
  end

  def validate(ctx, params:, **)
    ctx['contract.default'].validate(ctx['model'].attributes)
  end
end
