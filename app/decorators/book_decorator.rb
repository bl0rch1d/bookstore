class BookDecorator < Draper::Decorator
  include ActionView::Helpers

  delegate_all

  def thumb
    images.first.variant(resize: '50x50')
  end

  def cover
    images.first.variant(resize: '250x250')
  end

  def additional_images
    images.slice(1..3)
  end

  def short_description
    description.slice(1..63) + '...'
  end

  def price_in_currency
    number_to_currency(price, unit: '€')
  end

  def format_authors
    authors.map { |author| author.decorate.full_name }.join(', ')
  end

  def dimensions
    "H: #{height} \"\ x W: #{width} \"\ x D: #{depth} \"\ "
  end
end
