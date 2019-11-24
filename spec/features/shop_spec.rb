describe 'Shop page', type: :feature do
  let!(:books) { create_list(:book, 13) }

  before do
    visit books_path
  end

  it 'User can navigate by categories' do
    find('.filter-link', text: books.first.category.title, match: :first).click
    expect(page).to have_content(books.first.title)
  end

  it 'User can sort books' do
    find_link(I18n.t('sortings.text.title_ascending')).click

    find_link(I18n.t('sortings.text.high_price')).click

    find('.book_price', match: :first)

    expect(find('.book_price', match: :first)).to have_content(Book.descending_price.first.price)
  end

  it 'User can add book to cart' do
    find('i', class: 'fa-shopping-cart', match: :first, visible: false).click

    expect(page).to have_content(I18n.t('order_item.notice.added'))

    expect(Order.last.order_items.size).to eq(1)
    expect(find('span', class: 'shop-quantity').text.to_i).to eq(Order.last.order_items.size)
  end

  it 'User can go to book page' do
    find('i', class: 'fa-eye', match: :first, visible: false).click

    expect(page).to have_current_path("/books/#{Book.ascending_title.first.id}")
  end

  it 'User can view more books by navigating to the next page' do
    find('a', class: 'page-link', text: '2').click

    expect(page).to have_current_path(books_path(page: 2))
    expect(page).to have_content(Book.ascending_title.last.title)
  end
end
