# require_relative '../support/helpers/feature_spec_helper'

RSpec.describe 'Books page', type: :feature do
  let!(:book) { create(:book) }

  let(:values) do
    {
      valid: {
        title: 'title',
        body: 'body messages for book review'
      },

      invalid: {
        blank: ''
      }
    }
  end

  it 'user can put book into a “shopping cart”' do
    visit book_path(book.id)

    find("input[value='#{I18n.t('store.button.add_to_cart')}']").click

    expect(page).to have_content(I18n.t('order_item.notice.added'))
  end

  it 'user can view detailed information on a book' do
    visit category_books_path(0)

    find_link(class: 'book_path_link', visible: false).click

    expect(page).to have_content(book.title)
    expect(page).to have_content(book.decorate.format_authors)
    expect(page).to have_content(book.decorate.short_description)
    expect(page).to have_content(book.price)
    expect(page).to have_content(book.year)
  end

  # === TODO ===
  # context 'when user creates a review' do
  #   let(:user) { create(:user) }

  #   before do
  #     login_as(user, score: :user)

  #     page.set_rack_session(user_id: user.id)

  #     ApplicationController.instance_variable_set(:@current_user, user)
  #   end

  #   it 'success' do
  #     visit book_path(book.id)
  #     within '#new_review' do
  #       fill_in 'review[title]', with: values[:valid][:title]
  #       fill_in 'review[body]', with: values[:valid][:body]
  #       select rand(1..5), from: 'review[rating]'

  #       click_button(I18n.t('review.post'))
  #     end

  #     expect(page).to have_content(I18n.t('review.notice.sent'))
  #   end

  #   it 'fails with invalid params' do
  #     visit book_path(book.id)

  #     within '#new_review' do
  #       fill_in 'review[title]', with: values[:invalid][:blank]
  #       fill_in 'review[body]', with: values[:invalid][:blank]
  #       select rand(1..5), from: 'review[rating]'

  #       click_button(I18n.t('review.post'))
  #     end

  #     expect(page).to have_content(
  #       I18n.t('errors.format', attribute: :Title, message: I18n.t('errors.messages.blank'))
  #     )

  #     expect(page).to have_content(
  #       I18n.t('errors.format', attribute: :Body, message: I18n.t('errors.messages.blank'))
  #     )

  #     expect(page).to have_content(
  #       I18n.t('errors.format', attribute: :Body, message: I18n.t('errors.messages.invalid'))
  #     )
  #   end
  # end

  it 'book was not found' do
    visit book_path(123_456_789)

    expect(page).to have_content(I18n.t('store.not_found.message'))
  end
end
