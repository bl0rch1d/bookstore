require_relative 'feature_spec_helper'

RSpec.describe 'Books page', type: :feature do
  let!(:book) { create(:book, :full) }

  it 'user can put book into a “shopping cart”' do
    visit book_path(book.id)

    find("input[value='Add to cart']").click

    expect(page).to have_content(I18n.t('order_item.notice.added'))
  end

  it 'user can view detailed information on a book' do
    visit category_books_path(0)

    page.evaluate_script("$('.thumb-hover').css({'opacity': '1'});")

    find_link(class: 'book_path_link').click

    expect(page).to have_content(book.title)
    expect(page).to have_content(book.decorate.format_authors)
    expect(page).to have_content(book.decorate.short_description)
    expect(page).to have_content(book.price)
    expect(page).to have_content(book.year)
  end

  context 'when user creates a review' do
    before do
      register_user
      sign_in_user
    end

    it 'success' do
      visit book_path(book.id)

      within '#new_review' do
        fill_in 'review[title]', with: 'TITLE'
        fill_in 'review[body]', with: 'dsadsaddadadsadasdadsdadad'
        select '5', from: 'review[rating]'

        click_button('Post')
      end

      expect(page).to have_content(I18n.t('review.notice.sent'))
    end

    it 'fails with invalid params' do
      visit book_path(book.id)

      within '#new_review' do
        fill_in 'review[title]', with: ''
        fill_in 'review[body]', with: 'sasassas'
        select '5', from: 'review[rating]'

        click_button('Post')
      end

      expect(page).to have_content("can't be blank")
    end
  end

  it 'book was not found' do
    visit book_path(123_456_789)

    expect(page).to have_content("The page you were looking for doesn't exist.")
  end
end
