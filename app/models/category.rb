class Category < ApplicationRecord
  has_many :books, dependent: :destroy

  validates :title, presence: true, length: { maximum: MAX_TITLE_LENGTH }, uniqueness: true
end
