class Book::Policy::IndexGuard
  include Uber::Callable

  def call(ctx, params:, **)
    params[:category_id] == 0 ? true : Category.exists?(params[:category_id])
  end
end
