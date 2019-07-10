class ReviewsController < ApplicationController
  # === TODO: Refactor ===
  def create
    review = Review.new

    review.title        = params[:review][:title]
    review.body         = params[:review][:body]
    review.rating       = params[:review][:rating]
    review.customer_id  = current_customer.id
    review.book_id      = params[:book_id]
    review.verified     = current_customer.bought?(params[:book_id]) || false

    if review.save
      flash[:notice] = 'Review submited'
    else
      flash[:alert] = review.errors.full_messages
    end

    redirect_to book_url(params[:book_id])
  end

  private

  def review_params
    params.require(:review).permit(:title, :body, :rating, :user_id, :book_id)
  end
end
