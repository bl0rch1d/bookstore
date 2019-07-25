class Review::Create < Trailblazer::Operation
  step Model(Review, :new)
  step Policy::Guard(Review::Policy::CreateGuard.new), fail_fast: true
  step Contract::Build(constant: Review::Contract::Create)
  step Contract::Validate(), fail_fast: true
  success :define_verified
  step Contract::Persist()

  def define_verified(ctx, params:, **)
    user = params[:current_user]

    verified = user.orders.delivered.joins(:books).where(books: { id: params[:book_id] }).exists? ? true : false

    ctx['model'].verified = verified
  end
end
