class BooksController < ApplicationController
  include Pagy::Backend

  PAGINATION_VALUE = 12

  def index
    @pagy, @books = pagy(BooksSortingQuery.new(params).call, items: PAGINATION_VALUE)
  end

  def show
    @book = Book.find(params[:id])
    @reviews = @book.reviews.approved
  end
end
