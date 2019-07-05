class Book < ApplicationRecord
  belongs_to :category

  has_and_belongs_to_many :authors
  has_and_belongs_to_many :materials

  has_many :reviews, dependent: :destroy
  has_many :order_items, dependent: :destroy

  has_many_attached :images
  accepts_nested_attributes_for :images_attachments, allow_destroy: true

  validates :title, :description, :price, :year, :quantity, :height, :width, :depth, :category_id, presence: true

  validates :price, numericality: { greater_or_equal_to: 0, less_than_or_equal_to: 100_000 }
  validates :quantity, numericality: { only_integer: true, greater_or_equal_to: 0 }

  def self.latest
    Book.all.last(3)
  end
end
