class Review::Policy::CreateGuard
  include Uber::Callable

  def call(_ctx, params:, **)
    current_user = params[:current_user]
    review_user_id = params.dig(:review, :user_id)
    book_id = params.dig(:review, :book_id)

    user_legit?(current_user, review_user_id) && book_exists?(book_id)
  end

  private

  def user_legit?(current_user, review_user_id)
    current_user&.id == review_user_id.to_i
  end

  def book_exists?(id)
    Book.exists?(id)
  end
end
