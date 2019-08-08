class Order::Index < Trailblazer::Operation
  step :model

  def model(ctx, params:, **)
    ctx['model'] = Order::Query::Index.new.call(ctx['current_user'], params)
  end
end
