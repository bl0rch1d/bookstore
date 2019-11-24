class Address < ApplicationRecord
  belongs_to :addressable, polymorphic: true

  enum type: { BillingAddress: 0, ShippingAddress: 1 }

  FIELDS = %i[first_name last_name address_line city zip country phone].freeze
end
