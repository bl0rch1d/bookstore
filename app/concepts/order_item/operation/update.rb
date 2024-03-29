class OrderItem::Update < Trailblazer::Operation
  step Policy::Guard(OrderItem::Policy::UpdateGuard.new, name: :user)
  step Model(OrderItem, :find_by), fail_fast: true
  step Contract::Build(constant: OrderItem::Contract::Create)
  step :quantity
  step :subtotal
  step Contract::Validate(key: :order_item), fail_fast: true
  step Contract::Persist()

  def quantity(ctx, params:, **)
    params[:order_item][:quantity] = ctx['model'].quantity + params[:order_item][:quantity].to_f
  end

  def subtotal(_ctx, model:, params:, **)
    params[:order_item][:subtotal] = model.price * params[:order_item][:quantity].to_f
  end
end
