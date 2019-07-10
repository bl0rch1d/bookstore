class Material < ApplicationRecord
  has_many :books_materials, dependent: :destroy
  has_many :books, through: :books_materials

  validates :title, presence: true, uniqueness: true, length: { maximum: MAX_TITLE_LENGTH }
end
