class ReviewsController < ApplicationController
  execute_and_authorize_operation

  def create
    if @operation_result.success?
      flash[:notice] = I18n.t('review.notice.sent')
    else
      flash[:alert] = contract_errors(@operation_result)
    end

    redirect_to book_url(params[:book_id])
  end
end
