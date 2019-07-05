class Category < ApplicationRecord
  has_many :books

  # === TODO: Constant ===
  validates :title, presence: true, uniqueness: true, length: { maximum: 50 }
end
