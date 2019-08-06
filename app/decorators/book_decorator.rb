class BookDecorator < Draper::Decorator
  delegate_all

  def thumb
    images.first.variant(resize: I18n.t('resize.thumb'))
  end

  def cover
    images.first.variant(resize: I18n.t('resize.cover'))
  end

  def additional_images
    images.slice(1..3)
  end

  def short_description
    description.slice(1..63) + '...'
  end

  def format_authors
    authors.map { |author| author.decorate.full_name }.join(', ')
  end

  def dimensions
    "H: #{height} \"\ x W: #{width} \"\ x D: #{depth} \"\ "
  end

  def inline_materials
    materials.map(&:title).join(', ')
  end
end
