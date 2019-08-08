class AdminUser < ApplicationRecord
  devise :database_authenticatable, :recoverable, :validatable, :timeoutable, :trackable
end
