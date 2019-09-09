class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :confirmable, :validatable,
         :recoverable, :rememberable, :trackable, :omniauthable, omniauth_providers: [:facebook]

  attr_accessor :remove_account

  has_many :reviews, dependent: :destroy
  has_many :orders, dependent: :destroy

  has_one :billing_address, as: :addressable, dependent: :destroy
  has_one :shipping_address, as: :addressable, dependent: :destroy

  accepts_nested_attributes_for :billing_address
  accepts_nested_attributes_for :shipping_address

  def self.from_omniauth(auth)
    where(email: auth.info.email).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token.first(Devise.password_length.first)
      user.provider = auth.provider
      user.uid = auth.uid
      user.skip_confirmation!
    end
  end

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end
end
