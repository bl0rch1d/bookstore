# require_relative '../support/helpers/feature_spec_helper'

RSpec.describe 'Review', type: :feature do
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
end
