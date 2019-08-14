class Order::Current < Trailblazer::Operation
  success :model
  success :session

  def model(ctx, params:, **)
    ctx['model'] = Order.find_or_create_by(id: params[:session][:current_order_id])
  end

  def session(ctx, params:, **)
    params[:session][:current_order_id] = ctx['model'].id
  end
end
