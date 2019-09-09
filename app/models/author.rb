class Author < ApplicationRecord
  FIRST_LAST_NAME_LENGTH = 50

  has_many :authors_books, dependent: :destroy
  has_many :books, through: :authors_books

  validates :first_name, :last_name, presence: true, length: { maximum: FIRST_LAST_NAME_LENGTH }
  validates :first_name, uniqueness: { scope: :last_name }
end
