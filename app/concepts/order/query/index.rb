module Order::Query
  class Index
    def self.call(user, params)
      query = new
      query.instance_variable_set(:@params, params)
      query.instance_variable_set(:@user, user)
      query.perform
    end

    def perform
      case @params[:sort_by]
      when I18n.t('order.filter.in_progress')  then in_progress
      when I18n.t('order.filter.in_delivery')  then in_delivery
      when I18n.t('order.filter.delivered')    then delivered
      when I18n.t('order.filter.canceled')     then canceled
      else in_progress
      end
    end

    delegate :in_progress, to: :orders

    delegate :in_delivery, to: :orders

    delegate :delivered,   to: :orders

    delegate :canceled,    to: :orders

    def orders
      @user.orders
    end
  end
end
