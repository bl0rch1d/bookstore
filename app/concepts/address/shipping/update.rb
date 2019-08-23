class Address::Shipping::Update < Trailblazer::Operation
  step Policy::Guard(Address::Policy::UpdateGuard.new, name: :user), fail_fast: true
  step Nested(Address::Edit)
  success :extract_params

  step Contract::Validate(key: :shipping_address), fail_fast: true
  step Contract::Persist()

  def extract_params(ctx, params:, **)
    params[:shipping_address] = params.dig(:user, :shipping_address_attributes)

    ctx['contract.default'] = ctx['shipping_address_form']
  end
end
