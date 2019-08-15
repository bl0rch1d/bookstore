class Material < ApplicationRecord
  TITLE_LENGTH = 50

  has_many :books_materials, dependent: :destroy
  has_many :books, through: :books_materials

  validates :title, presence: true, uniqueness: true, length: { maximum: TITLE_LENGTH }
end
