RSpec.describe 'Home page', type: :feature do
  before do
    create(:category, :with_books)

    visit(root_path)
  end

  it 'User can see latest books slider and buy it' do
    within '.carousel.slide' do
      expect(page).to have_selector('.item', count: 3, visible: false)

      expect(page).to have_content(Category.last.books.third.title)
      expect(page).to have_content(Category.last.books.third.description)

      first('.right').click

      expect(page).to have_content(Category.last.books.fourth.title)
      expect(page).to have_content(Category.last.books.fourth.description)
    end
  end

  it 'User can click the get started button and come to books page' do
    click_link(I18n.t('store.get_started'))
    expect(page).to have_current_path(category_books_path(0))
  end
end
