module CheckoutStep::Contract
  class CreditCard < Reform::Form
    NAME_LENGTH           = 50
    NAME_REGEX            = /\A[a-zA-Z' ]+\z/.freeze
    NUMBER_REGEX          = /\A[0-9]+\z/.freeze
    NUMBER_RANGE          = (16..18).freeze
    EXPIRATION_DATE_REGEX = %r{\A(0[1-9]|1[0-2])/([0-9]{2}|[0-9]{2})\z}.freeze
    CVV_RANGE             = (3..4).freeze

    property :card_name
    property :number
    property :cvv
    property :expiration_date
    property :order_id

    validates :card_name, :number, :cvv, :expiration_date, presence: true

    validates :number, format: { with: NUMBER_REGEX }, length: { in: NUMBER_RANGE }
    validates :card_name, format: { with: NAME_REGEX }, length: { maximum: NAME_LENGTH }
    validates :expiration_date, format: { with: EXPIRATION_DATE_REGEX }
    validates :cvv, length: { in: CVV_RANGE }
    validates :order_id, numericality: { only_indeger: true }
  end
end
