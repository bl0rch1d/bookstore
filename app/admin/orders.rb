ActiveAdmin.register Order do
  permit_params :state

  scope :all
  scope :in_progress
  scope :in_delivery
  scope :delivered
  scope :canceled

  index do
    selectable_column

    column :number
    column :created_at
    column :state

    column do |resource|
      link_to I18n.t('order.admin_actions.change'), resource_path(resource)
    end
  end

  controller do
    actions :all, except: [:edit]
  end

  action_item :deliver, only: :show do
    if order.processing? && order.state == I18n.t('order.states.in_progress').downcase.split.join('_')
      link_to(I18n.t('order.admin_actions.deliver'), deliver_admin_order_path(order), method: :put)
    end
  end

  action_item :confirm_delivery, only: :show do
    if order.state == I18n.t('order.states.in_delivery').downcase.split.join('_')
      link_to I18n.t('order.admin_actions.confirm_delivery'), confirm_delivery_admin_order_path(order), method: :put
    end
  end

  action_item :cancel, only: :show do
    link_to I18n.t('order.admin_actions.cancel'), cancel_admin_order_path(order), method: :put if order.processing?
  end

  member_action :deliver, method: :put do
    order = Order.find(params[:id])

    order.deliver!

    redirect_to admin_order_path(order)
  end

  member_action :confirm_delivery, method: :put do
    order = Order.find(params[:id])

    order.confirm_delivery!

    redirect_to admin_order_path(order)
  end

  member_action :cancel, method: :put do
    order = Order.find(params[:id])

    order.cancel!

    redirect_to admin_order_path(order)
  end
end
