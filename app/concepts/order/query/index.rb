module Order::Query
  class Index
    def self.call(customer, params)
      query = new
      query.instance_variable_set(:@params, params)
      query.instance_variable_set(:@customer, customer)
      query.perform
    end

    def perform
      case @params[:sort_by]
      when 'in_progress'  then in_progress
      when 'in_delivery'  then in_delivery
      when 'delivered'    then delivered
      when 'canceled'     then canceled
      else in_progress
      end
    end

    delegate :in_progress, to: :orders

    delegate :in_delivery, to: :orders

    delegate :delivered, to: :orders

    delegate :canceled, to: :orders

    def orders
      @customer.orders
    end
  end
end
