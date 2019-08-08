class BooksController < ApplicationController
  def index
    result = Book::Index.call(params)

    # binding.pry

    return redirect_to(books_path) unless result.success?

    @pagy = result['pagy']
    @books = BookDecorator.decorate_collection(result['model'])
  end

  def show
    result = Book::Show.call(id: params[:id])

    @path = request.referer.presence || root_path

    @book = result['model'].decorate
    @reviews = ReviewDecorator.decorate_collection(@book.reviews.approved)
  end
end
