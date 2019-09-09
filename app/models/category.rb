class Category < ApplicationRecord
  TITLE_LENGTH = 50

  has_many :books, dependent: :destroy

  validates :title, presence: true, length: { maximum: TITLE_LENGTH }, uniqueness: true
end
