class BooksController < ApplicationController
  def index
    result = Book::Index.call(params)

    return redirect_to(category_books_path(0)) unless result.success?

    @pagy = result['pagy']
    @books = result['model']
  end

  def show
    result = Book::Show.call(id: params[:id])

    return redirect_to(category_books_path(0)) unless result.success?

    @book = result['model']
    @reviews = @book.reviews.approved
  end
end
