class Checkout::Finish < Trailblazer::Operation
  step :complete_order
  success :clear_session

  def complete_order(ctx, params:, **)
    current_customer = params['current_customer']
    current_order    = params['current_order']

    current_order.update(number: current_order.decorate.generate_number,
                         customer_id: current_customer.id,
                         total_price: current_order.decorate.total,
                         completed_at: Time.zone.now.strftime('%d %b %Y - %H:%M:%S'))
  end

  def clear_session(ctx, params:, **)
    params['session'][:current_order_id] = nil
  end
end
