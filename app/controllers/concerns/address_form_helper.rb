module AddressFormHelper
  extend ActiveSupport::Concern

  included do
    def expose_address_forms(result)
      @billing_address_form   = result['billing_address_form']
      @shipping_address_form  = result['shipping_address_form']
    end
  end
end
