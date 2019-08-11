class OrderItemsController < ApplicationController
  def index
    result = OrderItem::Index.call(params.merge(current_order: current_order))

    authorize!(result)

    @items = result['model']
  end

  def create
    result = OrderItem::Create.call(params.merge(current_order: current_order))

    authorize!(result)

    if result.success?
      redirect_back(fallback_location: root_path, notice: I18n.t('order_item.notice.added'))
    else
      redirect_back(fallback_location: root_path, alert: contract_errors(result))
    end
  end

  def update
    result = OrderItem::Update.call(params.merge(current_order: current_order))

    authorize!(result)

    if result.success?
      redirect_back(fallback_location: root_path, notice: I18n.t('order_item.notice.updated'))
    else
      redirect_back(fallback_location: root_path, alert: contract_errors(result))
    end
  end

  def destroy
    result = OrderItem::Delete.call(params.merge(current_order: current_order))

    authorize!(result)

    if result.success?
      redirect_back(fallback_location: root_path, notice: I18n.t('order_item.notice.removed'))
    else
      redirect_back(fallback_location: root_path, alert: contract_errors(result))
    end
  end
end
