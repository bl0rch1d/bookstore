class Customer < ApplicationRecord
  # === TODO: Auth ===
  # devise :database_authenticatable, :registerable, :confirmable, :validatable, :recoverable, :rememberable, :secure_validatable

  devise :database_authenticatable, :registerable, :validatable

  has_many :reviews

  has_many :orders

  has_one :billing_address, as: :addressable, dependent: :destroy
  has_one :shipping_address, as: :addressable, dependent: :destroy
end
