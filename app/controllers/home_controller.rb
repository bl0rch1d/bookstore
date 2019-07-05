class HomeController < ApplicationController
  decorates_assigned :latest_books

  def index
    @latest_books = Book.latest
    @categories = Category.all

    @best_sellers = BestSellersQuery.new.call
  end
end
