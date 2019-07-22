RSpec.describe BookDecorator do
  subject(:book) { create(:book).decorate }

  before do
    5.times do
      book.images.attach(io: File.open(Rails.root.join("spec/fixtures/books/#{rand(1..4)}.jpg")),
                         filename: 'cover.jpg', content_type: 'image/jpg')
    end
  end

  it '#thumb' do
    expect(book.thumb.variation.transformations[:resize]).to eq(book.images.first.variant(resize: '50x50')
                                                              .variation.transformations[:resize])
  end

  it '#cover' do
    expect(book.cover.variation.transformations[:resize]).to eq(book.images.first.variant(resize: '250x250')
                                                              .variation.transformations[:resize])
  end

  it '#additional_images' do
    expect(book.additional_images.size).to eq(3)
  end

  it '#short_description' do
    expect(book.short_description).to eq(book.description.slice(1..63) + '...')
  end

  it '#price_in_currency' do
    expect(book.price_in_currency.to_s).to eq("€#{book.price}")
  end

  it '#format_authors' do
    expect(book.format_authors).to eq(book.authors.map { |author| author.decorate.full_name }.join(', '))
  end

  it '#dimensions' do
    expect(book.dimensions).to eq("H: #{book.height} \"\ x W: #{book.width} \"\ x D: #{book.depth} \"\ ")
  end
end
