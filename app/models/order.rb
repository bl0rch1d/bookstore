class Order < ApplicationRecord
  include AASM

  belongs_to :customer
  belongs_to :shipping_method

  has_many :order_items
  has_many :books, through: :order_items

  has_one :shipping_address, as: :addressable, dependent: :destroy
  has_one :billing_address, as: :addressable, dependent: :destroy

  has_one :credit_card
  has_one :coupon

  belongs_to :shipping_method, optional: true
  belongs_to :customer, optional: true

  scope :completed, -> { where(completed_at) }

  aasm column: :state do
    state :in_progress, initial: true
    state :in_delivery, :delivered, :canceled

    event :deliver do
      transitions from: :in_progress, to: :in_delivery
    end

    event :confirm_delivery do
      transitions from: :in_delivery, to: :delivered
    end

    event :cancel do
      transitions to: :canceled
    end
  end
end
