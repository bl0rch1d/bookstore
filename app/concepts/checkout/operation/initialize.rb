class Checkout::Initialize < Trailblazer::Operation
  success :set_customer

  def set_customer(_ctx, params:, **)
    params['current_order'].update(customer_id: params['current_customer'].id)
  end
end
