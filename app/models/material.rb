class Material < ApplicationRecord
  has_many :books_materials, dependent: :destroy
  has_many :books, through: :books_materials

  # === TODO: Constant ===
  validates :title, presence: true, uniqueness: true, length: { maximum: 50 }
end
