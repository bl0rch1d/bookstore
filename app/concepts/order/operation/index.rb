class Order::Index < Trailblazer::Operation
  step :model

  def model(ctx, params:, **)
    ctx['model'] = Order::Query::Index.call(ctx['user'], params)
  end
end
