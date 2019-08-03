module User::Contract
  class Create < Reform::Form
    property :email
    property :password

    validates :email, :password, presence: true

    validates :email, format: { with: Devise.email_regexp }
    validates :password, length: { within: Devise.password_length }
    validates_uniqueness_of :email, case_sensitive: true
  end
end
