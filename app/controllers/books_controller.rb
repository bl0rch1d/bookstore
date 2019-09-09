class BooksController < ApplicationController
  include BackUrlMemorizer

  def index
    result = Book::Index.call(params)

    return redirect_to(books_path) unless result.success?

    @pagy = result['pagy']
    @books = BookDecorator.decorate_collection(result['model'])
  end

  def show
    result = Book::Show.call(id: params[:id])

    set_back_url

    @book = result['model'].decorate

    @reviews = ReviewDecorator.decorate_collection(@book.reviews.approved)
  end
end
