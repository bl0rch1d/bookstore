class BookDecorator < Draper::Decorator
  delegate_all

  def cover
    book_images.first.image.medium.url
  end

  def format_authors
    authors.map(&:to_s).join(', ')
  end

  def dimensions
    "H: #{height} \"\ x W: #{width} \"\ x D: #{depth} \"\ "
  end
end
