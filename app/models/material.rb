class Material < ApplicationRecord
  has_and_belongs_to_many :books

  # === TODO: Constant ===
  validates :title, presence: true, uniqueness: true, length: { maximum: 50 }
end
