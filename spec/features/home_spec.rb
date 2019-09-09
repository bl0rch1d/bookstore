describe 'Home page', type: :feature do
  before do
    create(:category, :with_books)

    visit(root_path)
  end

  it 'User can see latest books' do
    within '.carousel.slide' do
      expect(page).to have_selector('.item', count: 3, visible: false)

      expect(page).to have_content(Category.last.books.third.title)
      expect(page).to have_content(Category.last.books.third.description)

      first('.right').click

      expect(page).to have_content(Category.last.books.fourth.title)
      expect(page).to have_content(Category.last.books.fourth.description)
    end
  end

  it 'User can see bestsellers' do
    best_seller_book = BestSellersQuery.new(Category.all).call[0].decorate

    expect(page).to have_content(best_seller_book.title)
    expect(page).to have_content(best_seller_book.format_authors)
  end

  it 'User can go to book page' do
    find('i', class: 'fa-eye', match: :first, visible: false).click

    expect(page).to have_current_path("/books/#{Book.first.id}")
  end

  context 'when adding book to cart' do
    it 'via buy_now button' do
      click_link(I18n.t('store.button.buy_now'))

      expect(page).to have_content(I18n.t('order_item.notice.added'))

      expect(Order.last.order_items.size).to eq(1)
      expect(find('span', class: 'shop-quantity').text.to_i).to eq(Order.last.order_items.size)
    end

    it 'via add_to_cart icon' do
      find('i', class: 'fa-shopping-cart', match: :first, visible: false).click

      expect(page).to have_content(I18n.t('order_item.notice.added'))

      expect(Order.last.order_items.size).to eq(1)
      expect(find('span', class: 'shop-quantity').text.to_i).to eq(Order.last.order_items.size)
    end
  end

  context 'when User goes to Catalog page' do
    it 'via Shop menu' do
      click_link(I18n.t('store.menu.shop'))
      click_link(I18n.t('categories.all'))

      expect(page).to have_current_path(books_path)
    end

    it 'via get_started button' do
      click_link(I18n.t('store.get_started'))
      expect(page).to have_current_path(books_path)
    end
  end
end
