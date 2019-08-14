class PagesController < ApplicationController
  def home
    @latest_books = BookDecorator.decorate_collection(Book.includes(:authors, images_attachments: :blob).latest)
    @categories = Category.all

    @best_sellers = BookDecorator.decorate_collection(BestSellersQuery.new(@categories).call)
  end
end
