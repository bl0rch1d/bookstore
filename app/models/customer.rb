class Customer < ApplicationRecord
  # === TODO: Auth ===
  # devise :database_authenticatable, :registerable, :confirmable, :validatable,
  #        :recoverable, :rememberable, :trackable, :omniauthable

  # for seeding
  devise :database_authenticatable, :registerable, :validatable, :omniauthable

  has_one_attached :avatar

  has_many :reviews

  has_many :orders

  has_one :billing_address, as: :addressable, dependent: :destroy
  has_one :shipping_address, as: :addressable, dependent: :destroy

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |customer|
      customer.email = auth.info.email
      customer.password = Devise.friendly_token[0, 20]
    end
  end
end
