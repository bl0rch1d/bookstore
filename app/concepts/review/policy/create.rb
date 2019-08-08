class Review::Policy::CreateGuard
  include Uber::Callable

  def call(_ctx, params:, **)
    params[:current_user].present? && params[:current_user].id == params[:user_id].to_i && Book.exists?(params[:book_id])
  end
end
