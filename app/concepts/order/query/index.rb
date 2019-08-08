module Order::Query
  class Index
    def call(user, params)
      @params = params
      @user = user

      case @params[:sort_by]
      when I18n.t('order.filter.in_progress')  then in_progress
      when I18n.t('order.filter.in_delivery')  then in_delivery
      when I18n.t('order.filter.delivered')    then delivered
      when I18n.t('order.filter.canceled')     then canceled
      when I18n.t('order.all')                 then orders
      else in_progress
      end
    end

    delegate :in_progress, to: :orders

    delegate :in_delivery, to: :orders

    delegate :delivered,   to: :orders

    delegate :canceled,    to: :orders

    def orders
      @user.orders.completed
    end
  end
end
