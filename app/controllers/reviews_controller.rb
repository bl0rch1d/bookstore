class ReviewsController < ApplicationController
  def create
    result = Review::Create.call(params[:review].merge(current_user: current_user))

    if result.success?
      flash[:notice] = I18n.t('review.notice.sent')
    else
      flash[:alert] = operation_errors(result)
    end

    redirect_to book_url(params[:book_id])
  end
end
