RSpec.describe 'Books page', type: :feature do
  let!(:book) { create(:book) }

  it 'user can put book into a “shopping cart”' do
    visit book_path(book.id)

    find("input[value='#{I18n.t('store.button.add_to_cart')}']").click

    expect(page).to have_content(I18n.t('order_item.notice.added'))
  end

  it 'user can view detailed information on a book' do
    visit books_path

    find_link(class: 'book_path_link', visible: false).click

    expect(page).to have_content(book.title)
    expect(page).to have_content(book.decorate.format_authors)
    expect(page).to have_content(book.decorate.short_description)
    expect(page).to have_content(book.price)
    expect(page).to have_content(book.year)
  end

  it 'user can see full description' do
    visit book_path(book.id)

    find('#full_description_show').click

    expect(find('#full_description').text[0..-11]).to eq(book.description)
  end

  it 'user sees error page if book not found' do
    visit book_path(123_456_789)

    expect(page).to have_content(I18n.t('store.not_found.message'))
  end
end