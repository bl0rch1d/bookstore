class ReviewsController < ApplicationController
  before_action :sanitize_rating

  def create
    result = Review::Create.call(params[:review], 'current_user' => current_customer)

    if result.success?
      flash[:notice] = 'Thanks for Review. It will be published as soon as Admin will approve it.'
    else
      flash[:alert] = result['result.contract.default'].errors.messages
    end

    redirect_to book_url(params[:book_id])
  end

  private

  def sanitize_rating
    params[:review][:rating] = params[:review][:rating].to_i
  end
end
