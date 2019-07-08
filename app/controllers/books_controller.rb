class BooksController < ApplicationController
  include Pagy::Backend

  def index
    @pagy, @books = pagy(BooksSortingQuery.new(params).call, items: 12)
  end

  def show
    @book = Book.find(params[:id])
    @reviews = @book.reviews.approved
  end
end
