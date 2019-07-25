class Order::Index < Trailblazer::Operation
  step Contract::Build(constant: Order::Contract::Index)
  step Contract::Validate(), fail_fast: true
  step :model

  def model(ctx, params:, **)
    ctx['model'] = Order::Query::Index.call(ctx['current_user'], params)
  end
end
