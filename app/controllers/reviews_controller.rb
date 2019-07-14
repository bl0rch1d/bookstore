class ReviewsController < ApplicationController
  def create
    review = Review.new(customer_id: current_customer.id,
                        book_id: params[:book_id],
                        verified: current_customer.bought?(params[:book_id]))

    if review.update(review_params)
      flash[:notice] = 'Thanks for Review. It will be published as soon as Admin will approve it.'
    else
      flash[:alert] = review.errors.full_messages
    end

    redirect_to book_url(params[:book_id])
  end

  private

  def review_params
    params.require(:review).permit(:title, :body, :rating)
  end
end
