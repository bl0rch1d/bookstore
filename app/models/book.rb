class Book < ApplicationRecord
  mount_uploader :image, BookImageUploader

  belongs_to :category

  has_and_belongs_to_many :authors
  has_and_belongs_to_many :materials

  validates :title, :description, :price, :year, :quantity, :dimensions, presence: true

  validates :price, numericality: { greater_than: 0, less_than: 100_000 }
  validates :quantity, numericality: { only_integer: true, greater_or_equal_to: 0 }
end
