class BooksController < ApplicationController
  def index
    result = Book::Index.call(params)

    return redirect_to(category_books_path(0)) unless result.success?

    @pagy = result['pagy']
    @books = BookDecorator.decorate_collection(result['model'])
  end

  def show
    result = Book::Show.call(id: params[:id])

    raise ActiveRecord::RecordNotFound unless result['model']

    @path = request.referer.presence || root_path

    @book = result['model'].decorate
    @reviews = ReviewDecorator.decorate_collection(@book.reviews.approved)
  end
end
