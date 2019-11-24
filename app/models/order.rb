class Order < ApplicationRecord
  include AASM

  has_many :order_items, dependent: :destroy
  has_many :books, through: :order_items

  has_one :shipping_address, as: :addressable, dependent: :destroy
  has_one :billing_address, as: :addressable, dependent: :destroy

  has_one :credit_card, dependent: :destroy
  has_one :coupon, dependent: :destroy

  belongs_to :shipping_method, optional: true
  belongs_to :user, optional: true

  scope :completed, -> { where.not(completed_at: nil) }

  aasm column: :state do
    state :in_progress, initial: true
    state :in_delivery
    state :delivered
    state :canceled

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

  def processing?
    state != 'canceled' && state != 'delivered'
  end
end
