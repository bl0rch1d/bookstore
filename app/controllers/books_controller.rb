class BooksController < ApplicationController
  def index
    # === TODO: Refactor ===
    @current_filter = params[:category_id]
    # ======================

    result = Book::Index.call(params)

    @pagy = result['pagy']
    @books = result['model']
  end

  def show
    @book = Book::Show.call(id: params[:id])['model']

    @reviews = @book.reviews.approved
  end
end
