class Review::Policy::CreateGuard
  include Uber::Callable

  def call(_ctx, params:, **)
    params[:current_user]&.id == params.dig(:review, :user_id).to_i && Book.exists?(params.dig(:review, :book_id))
  end
end
