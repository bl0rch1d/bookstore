class Address::Create < Trailblazer::Operation
  # class Present < Trailblazer::Operation
  # end
  # step Nested(Present)

  # step Model(Address, :new)
  # step Contract::Build(constant: Address::Contract::Create)
  # step Contract::Validate()
  # step Contract::Persist()

  # step :model
  # step :set_attributes

  # def model(ctx, params:, **)
  #   if params.key?(:billing_address)
  #     return ctx['model'] = params[:current_order].billing_address ||
  #                           params[:current_customer].billing_address ||
  #                           BillingAddress.new
  #   end

  #   ctx['model'] = params[:current_order].shipping_address ||
  #                  params[:current_customer].shipping_address ||
  #                  ShippingAddress.new
  # end

  # def set_attributes(ctx, params:, **)
  #   ctx['model'].attributes = params[:billing_address]
  # end
end
