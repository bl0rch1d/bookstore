class BooksController < ApplicationController
  def index
    result = Book::Index.call(params)

    @pagy = result['pagy']
    @books = result['model']
  end

  def show
    @book = Book::Show.call(id: params[:id])['model']

    @reviews = @book.reviews.approved
  end
end
