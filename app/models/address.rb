class Address < ApplicationRecord
  belongs_to :addressable, polymorphic: true

  NAME_REGEX          = /\A[a-zA-Z]+\z/
  ADDRESS_REGEX       = /\A[ a-zA-Z\d,-]+\z/
  ZIP_REGEX           = /\A[\d-]+\z/
  CITY_COUNTRY_REGEX  = /\A[\p{L}\s'-.,]+\z/
  PHONE_REGEX         = /\A^[+][\d]+\z/

  NAME_LENGTH, ADDRESS_LENGTH, CITY_COUNTRY_LENGTH = Array.new(3) { 50 }
  ZIP_LENGTH          = 10
  PHONE_LENGTH        = 15

  validates :first_name, :last_name, :address, :zip, :city, :country, :phone, presence: true

  validates :first_name, :last_name, length: { maximum: NAME_LENGTH }, format: { with: NAME_REGEX }
  validates :address, length: { maximum: ADDRESS_LENGTH }, format: { with: ADDRESS_REGEX }
  validates :country, :city, length: { maximum: CITY_COUNTRY_LENGTH }, format: { with: CITY_COUNTRY_REGEX }
  validates :zip, length: { maximum: ZIP_LENGTH }, format: { with: ZIP_REGEX }
  validates :phone, length: { maximum: PHONE_LENGTH }, format: { with: PHONE_REGEX }
end
