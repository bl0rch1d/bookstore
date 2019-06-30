class Category < ApplicationRecord
  has_many :books

  validates :title, presence: true, uniqueness: true, length: { maximum: 50 }
end
