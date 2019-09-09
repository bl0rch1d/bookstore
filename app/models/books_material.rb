class BooksMaterial < ApplicationRecord
  belongs_to :book
  belongs_to :material
end
