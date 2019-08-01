RSpec.describe 'Home page', type: :feature do
  let!(:category) { create(:category, :with_books) }

  before do
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

      click_link('Buy Now')
    end

    expect(page).to have_current_path(root_path)
    expect(page).to have_content(I18n.t('order_item.notice.added'))
  end

  it 'User can click the get started button and come to books page' do
    click_link('Get Started')
    expect(page).to have_current_path(category_books_path(0))
  end

  # === Blob Error
  # it 'User can see bestsellers' do
  #   within '#bestsellers' do
  #     expect(page).to have_selector('.col-sm-6.col-md-3', count: Category.all.count)

  #     all('a', visible: false)[0].click

  #     expect(page).to have_current_path(book_path(category.books.first.id))
  #   end
  # end
end
