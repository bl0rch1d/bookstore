class Order < ApplicationRecord
  include AASM

  has_many :order_items, dependent: :destroy
  has_many :books, through: :order_items

  has_one :shipping_address, as: :addressable, dependent: :destroy
  has_one :billing_address, as: :addressable, dependent: :destroy

  # === TODO: Associations ===
  # has_one :credit_card
  # has_one :coupon
  # belongs_to :shipping_method
  # belongs_to :customer

  scope :completed, -> { where(completed_at) }

  aasm column: :state do
    state :in_progress, initial: true
    state :in_delivery
    state :delivered
    state :canceled

    event :deliver do
      transitions from: :in_progress, to: :in_delivery
    end

    event :confirm_delivery, after: :complete do
      transitions from: :in_delivery, to: :delivered
    end

    event :cancel do
      transitions to: :canceled
    end
  end

  def processing?
    state != 'canceled' && state != 'delivered'
  end

  private

  def complete
    update(completed_at: Time.now.strftime('%d %b %Y - %H:%M:%S'))
  end

  # === TODO: Normalniy query ===
  # Bestsellers query
  # books = Order.all.where(state: :delivered).flat_map(&:books)
  # results = books.map { |book| [book, books.count(book)]}.sort_by(&:second).last(4).map { |collection| collection.first.first.id}
end
