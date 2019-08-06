RSpec.describe BookDecorator do
  subject(:book) { create(:book, :with_many_images).decorate }

  it '#thumb' do
    resize_value = book.images.first.variant(resize: I18n.t('resize.thumb')).variation.transformations[:resize]

    expect(book.thumb.variation.transformations[:resize]).to eq(resize_value)
  end

  it '#cover' do
    resize_value = book.images.first.variant(resize: I18n.t('resize.cover')).variation.transformations[:resize]

    expect(book.cover.variation.transformations[:resize]).to eq(resize_value)
  end

  it '#additional_images' do
    expect(book.additional_images.size).to eq(3)
  end

  it '#short_description' do
    expect(book.short_description).to eq(book.description.slice(1..63) + '...')
  end

  it '#format_authors' do
    expect(book.format_authors).to eq(book.authors.map { |author| author.decorate.full_name }.join(', '))
  end

  it '#dimensions' do
    expect(book.dimensions).to eq("H: #{book.height} \"\ x W: #{book.width} \"\ x D: #{book.depth} \"\ ")
  end

  it '#inline_materials' do
    expect(book.inline_materials).to eq(book.materials.map(&:title).join(', '))
  end
end
