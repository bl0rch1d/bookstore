module Checkout::Contract
  class CreditCard < Reform::Form
    NAME_LENGTH           = 50
    NAME_REGEX            = /\A[a-zA-Z']+\z/.freeze
    NUMBER_REGEX          = /\A[0-9]+\z/.freeze
    EXPIRATION_DATE_REGEX = %r{\A(0[1-9]|1[0-2])/([0-9]{2}|[0-9]{2})\z}.freeze
    CVV_LENGTH            = (3..4).freeze

    property :card_name
    property :number
    property :cvv
    property :expiration_date

    validates :card_name, :number, :cvv, :expiration_date, presence: true

    validates :number, format: { with: NUMBER_REGEX }
    validates :card_name, format: { with: NAME_REGEX }, length: { maximum: NAME_LENGTH }
    validates :expiration_date, format: { with: EXPIRATION_DATE_REGEX }
    validates :cvv, length: { in: CVV_LENGTH }
  end
end
