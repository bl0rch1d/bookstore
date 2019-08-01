RSpec.describe 'Shop page', type: :feature do
  let!(:books) { create_list(:book, 10) }

  it 'user can navigate by categories' do
    visit category_books_path(0)
    find('.filter-link', text: books.first.category.title, match: :first).click
    expect(page).to have_content(books.first.title)
  end

  it 'user can sort books' do
    visit category_books_path(0)

    find_link('Title: A - Z').click

    find_link('Price: High to low').click

    find('.book_price', match: :first)

    expect(find('.book_price', match: :first)).to have_content(Book.descending_price.first.price)
  end
end
