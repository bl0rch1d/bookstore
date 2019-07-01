class Book < ApplicationRecord
  belongs_to :category

  has_and_belongs_to_many :authors
  has_and_belongs_to_many :materials

  has_many_attached :images

  validates :title, :description, :price, :year, :quantity, :dimensions, presence: true

  validates :price, numericality: { greater_or_equal_to: 0, less_than_or_equal_to: 100_000 }
  validates :quantity, numericality: { only_integer: true, greater_or_equal_to: 0 }
end
