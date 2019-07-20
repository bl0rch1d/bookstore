class OrderItemsController < ApplicationController
  def create
    params[:order_id] = current_order.id

    result = OrderItem::Create.call(params)

    if result.success?
      redirect_back(fallback_location: root_path, notice: I18n.t('order_item.notice.added'))
    else
      redirect_back(fallback_location: root_path, alert: result['result.contract.default'].errors.messages)
    end
  end

  def update
    result = OrderItem::Update.call(id: params[:id], quantity: params[:quantity])

    if result.success?
      redirect_back(fallback_location: root_path, notice: I18n.t('order_item.notice.updated'))
    else
      redirect_back(fallback_location: root_path, alert: result['result.model.errors'])
    end
  end

  def destroy
    result = OrderItem::Delete.call(id: params[:id])

    if result.success?
      redirect_back(fallback_location: root_path, notice: I18n.t('order_item.notice.removed'))
    else
      redirect_back(fallback_location: root_path, alert: result['result.contract.default'].errors.messages)
    end
  end
end
