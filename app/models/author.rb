class Author < ApplicationRecord
  has_many :authors_books, dependent: :destroy
  has_many :books, through: :authors_books

  validates :first_name, :last_name, presence: true, length: { maximum: MAX_TITLE_LENGTH }
  validates :first_name, uniqueness: { scope: :last_name }
end
