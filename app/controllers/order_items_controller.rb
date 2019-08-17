class OrderItemsController < ApplicationController
  execute_and_authorize_operation

  def index
    @items = @operation_result['model']
  end

  def create
    if @operation_result.success?
      redirect_back(fallback_location: root_path, notice: I18n.t('order_item.notice.added'))
    else
      redirect_back(fallback_location: root_path, alert: contract_errors(@operation_result))
    end
  end

  def update
    if @operation_result.success?
      redirect_back(fallback_location: root_path, notice: I18n.t('order_item.notice.updated'))
    else
      redirect_back(fallback_location: root_path, alert: contract_errors(@operation_result))
    end
  end

  def destroy
    if @operation_result.success?
      redirect_back(fallback_location: root_path, notice: I18n.t('order_item.notice.removed'))
    else
      redirect_back(fallback_location: root_path, alert: contract_errors(@operation_result))
    end
  end
end
