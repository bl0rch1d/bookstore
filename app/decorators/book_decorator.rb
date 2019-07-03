class BookDecorator < Draper::Decorator
  delegate_all

  def thumb
    book_images.first.image.small.url
  end

  def cover
    book_images.first.image.medium.url
  end

  def short_description
    description.slice(1..63) + '...'
  end

  def price_in_currency
    "€#{price}"
  end

  def format_authors
    authors.map(&:to_s).join(', ')
  end

  def dimensions
    "H: #{height} \"\ x W: #{width} \"\ x D: #{depth} \"\ "
  end
end
