class HomeController < ApplicationController
  def index
    @latest_books = BookDecorator.decorate_collection(Book.latest)
    @categories = Category.all

    @best_sellers = BookDecorator.decorate_collection(BestSellersQuery.new(@categories).call)
  end
end
