class Address < ApplicationRecord
  belongs_to :addressable, polymorphic: true

  FIELDS = %i[first_name last_name address city zip country phone].freeze
end
