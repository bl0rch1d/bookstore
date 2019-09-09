class Checkout::Payment::Edit < Trailblazer::Operation
  step Policy::Guard(Checkout::Policy::UserGuard.new, name: :user), fail_fast: true

  step :model
  step Contract::Build(constant: Checkout::Payment::Contract::CreditCard)

  def model(ctx, params:, **)
    ctx['model'] = params[:current_order].credit_card || CreditCard.new
  end
end
