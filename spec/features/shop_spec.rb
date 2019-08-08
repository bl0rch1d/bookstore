RSpec.describe 'Shop page', type: :feature do
  let!(:books) { create_list(:book, 10) }

  it 'User can navigate by categories' do
    visit books_path
    find('.filter-link', text: books.first.category.title, match: :first).click
    expect(page).to have_content(books.first.title)
  end

  it 'User can sort books' do
    visit books_path

    find_link(I18n.t('sortings.text.title_ascending')).click

    find_link(I18n.t('sortings.text.high_price')).click

    find('.book_price', match: :first)

    expect(find('.book_price', match: :first)).to have_content(Book.descending_price.first.price)
  end

  it 'User can add book to cart'

  it 'User can go to book page'

  it 'User can view more books by navigating to the next page'
end
