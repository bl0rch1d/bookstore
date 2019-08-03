class ReviewsController < ApplicationController
  before_action :sanitize_rating

  def create
    result = Review::Create.call(params[:review].merge(current_user: current_user))

    if result.success?
      flash[:notice] = I18n.t('review.notice.sent')
    else
      flash[:alert] = result['result.contract.default'].errors.full_messages
    end

    redirect_to book_url(params[:book_id])
  end

  private

  def sanitize_rating
    params[:review][:rating] = params[:review][:rating].to_i
  end
end
