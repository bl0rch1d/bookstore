class Review::Policy::CreateGuard
  include Uber::Callable

  def call(_ctx, params:, **)
    params[:current_user].present? && Book.exists?(params[:book_id])
  end
end
