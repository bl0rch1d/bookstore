class BooksController < ApplicationController
  include BackUrlMemorizer

  execute_operation

  def index
    return redirect_to(books_path) unless @operation_result.success?

    @pagy = @operation_result['pagy']
    @books = BookDecorator.decorate_collection(@operation_result['model'])
  end

  def show
    set_back_url

    @book = @operation_result['model'].decorate

    @reviews = ReviewDecorator.decorate_collection(@book.reviews.approved)
  end
end
