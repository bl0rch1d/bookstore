class Book < ApplicationRecord
  MIN_QUANTITY = 0
  MAX_QUANTITY = 100

  PAGINATION_INDEX = 12

  belongs_to :category

  has_many :authors_books, dependent: :destroy
  has_many :authors, through: :authors_books

  has_many :books_materials, dependent: :destroy
  has_many :materials, through: :books_materials

  has_many :reviews, dependent: :destroy
  has_many :order_items, dependent: :destroy

  has_many_attached :images
  accepts_nested_attributes_for :images_attachments, allow_destroy: true

  validates :title, :description, :price, :year, :quantity, :height, :width, :depth, :category_id, presence: true

  validates :title, uniqueness: true, length: { maximum: MAX_TITLE_LENGTH }
  validates :price, numericality: { greater_than_or_equal_to: MIN_PRICE, less_than_or_equal_to: MAX_PRICE }

  validates :quantity, numericality: {
    only_integer: true,
    greater_than_or_equal_to: MIN_QUANTITY,
    less_than_or_equal_to: MAX_QUANTITY
  }

  scope :most_popular,     -> { left_outer_joins(:order_items).group(:id).order('count(order_items.id) desc') }

  scope :most_recent,      -> { order('created_at DESC') }

  scope :ascending_title,  -> { order('title ASC') }
  scope :descending_title, -> { order('title DESC') }

  scope :ascending_price,  -> { order('price ASC') }
  scope :descending_price, -> { order('price DESC') }

  scope :latest,           -> { last(3) }
end
