RSpec.describe 'Home page', type: :feature do
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

  it 'User can see bestsellers'

  it 'User can go to book page'

  context 'when adding book to cart' do
    it 'via buy_now button'
    it 'via add_to_cart icon'
  end

  context 'when User goes to Catalog page' do
    it 'via Catalog menu'
    it 'via get_started button' do
      click_link(I18n.t('store.get_started'))
      expect(page).to have_current_path(books_path)
    end
  end

  context 'when User logged in' do
    it 'User can go to settings page'
    it 'User can go to orders page'
  end
end
