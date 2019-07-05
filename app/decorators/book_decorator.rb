class BookDecorator < Draper::Decorator
  delegate_all

  # === TODO: Refactor ===
  def thumb
    images.first.variant(resize: '100x100')
  end

  def cover
    images.first.variant(resize: '250x250')
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
