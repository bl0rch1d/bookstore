class BooksController < ApplicationController
  def index
    @books_count = Book.all.count
  end

  def show
    @book = Book.find(params[:id])
    @reviews = @book.reviews.approved

    @cover = @book.decorate.cover
    @other_images = @book.book_images.slice(1..-1)
  end
end
