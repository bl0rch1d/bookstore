class BookImage < ApplicationRecord
  mount_uploader :image, BookImageUploader

  belongs_to :book
end
