class Checkout::Payment::Update < Trailblazer::Operation
  step Nested(Checkout::Payment::Edit)
  success :extract_params
  step Contract::Validate(key: :credit_card), fail_fast: true
  step Contract::Persist()

  def extract_params(_ctx, params:, **)
    params[:credit_card] = params.dig(:order, :credit_card)
  end
end
