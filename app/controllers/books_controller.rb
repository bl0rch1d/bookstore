class BooksController < ApplicationController
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

  private

  def set_back_url
    cookies[:referer] = request.referer if request.referer

    @back_url = cookies[:referer] || root_path
  end
end
