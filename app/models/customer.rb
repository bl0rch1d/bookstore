class Customer < ApplicationRecord
  # === for prod ===
  devise :database_authenticatable, :registerable, :confirmable, :validatable,
         :recoverable, :rememberable, :trackable, :omniauthable

  attr_accessor :remove_account

  # === for seeds ===
  # devise :database_authenticatable, :registerable, :validatable, :omniauthable, :rememberable, :recoverable

  has_many :reviews, dependent: :destroy
  has_many :orders, dependent: :destroy

  has_one :billing_address, as: :addressable, dependent: :destroy
  has_one :shipping_address, as: :addressable, dependent: :destroy

  accepts_nested_attributes_for :billing_address
  accepts_nested_attributes_for :shipping_address

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |customer|
      customer.email = auth.info.email
      customer.password = Devise.friendly_token[0, 20]
    end
  end

  def bought?(book_id)
    orders.delivered.joins(:books).where(books: { id: book_id }).exists?
  end
end
