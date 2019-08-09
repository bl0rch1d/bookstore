class OrderItemsController < ApplicationController
  def index
    @items = OrderItem::Index.call(order: current_order)['model']
  end

  def create
    result = OrderItem::Create.call(params)

    if result.success?
      redirect_back(fallback_location: root_path, notice: I18n.t('order_item.notice.added'))
    else
      redirect_back(fallback_location: root_path, alert: operation_errors(result))
    end
  end

  def update
    result = OrderItem::Update.call(params)

    if result.success?
      redirect_back(fallback_location: root_path, notice: I18n.t('order_item.notice.updated'))
    else
      redirect_back(fallback_location: root_path, alert: operation_errors(result))
    end
  end

  def destroy
    result = OrderItem::Delete.call(id: params[:id])

    if result.success?
      redirect_back(fallback_location: root_path, notice: I18n.t('order_item.notice.removed'))
    else
      redirect_back(fallback_location: root_path, alert: operation_errors(result))
    end
  end
end
