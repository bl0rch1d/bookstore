class Address::Billing::Update < Trailblazer::Operation
  step Policy::Guard(Address::Policy::UpdateGuard.new, name: :user), fail_fast: true
  step Nested(Address::Edit)
  success :extract_params

  step Contract::Validate(key: :billing_address), fail_fast: true
  step Contract::Persist()

  def extract_params(ctx, params:, **)
    params[:billing_address] = params.dig(:user, :billing_address_attributes)

    ctx['contract.default'] = ctx['billing_address_form']
  end
end
