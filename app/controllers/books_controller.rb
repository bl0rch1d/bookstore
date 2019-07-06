class BooksController < ApplicationController
  def index
    # === TODO: Books count per category. Pagination(12 books) ===
  end

  def show
    @book = Book.find(params[:id])
    @reviews = @book.reviews.approved

    # === TODO: Refactor ===
    @cover = @book.decorate.cover
    @other_images = @book.images.slice(1..3)
  end
end
