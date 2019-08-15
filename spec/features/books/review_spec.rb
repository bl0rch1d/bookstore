describe 'Review', type: :feature do
  let(:book) { create(:book) }

  let(:values) do
    {
      valid: {
        title: 'title',
        body: 'body messages for book review'
      },

      invalid: {
        blank: 32.chr,
        long: 70.chr * 600
      }
    }
  end

  let!(:user) { create(:user) }

  before do
    visit book_path(book.id)
    login_as(user, scope: :user)
    page.driver.browser.navigate.refresh
  end

  describe 'Success' do
    it 'creates a review' do
      within '#new_review' do
        fill_in 'review[title]', with: values[:valid][:title]
        fill_in 'review[body]', with: values[:valid][:body]
        select rand(1..5), from: 'review[rating]'

        click_button(I18n.t('review.post'))
      end

      expect(page).to have_content(I18n.t('review.notice.sent'))
    end
  end

  describe 'Failure' do
    before do
      visit book_path(book.id)
    end

    it 'user sees client validation errors' do
      within '#new_review' do
        fill_in 'review[title]', with: values[:invalid][:blank]
        fill_in 'review[body]', with: values[:invalid][:blank]
        select rand(1..5), from: 'review[rating]'

        click_button(I18n.t('review.post'))
      end

      message = find('#title').native.attribute('validationMessage')

      expect(message).to match(I18n.t('validation_notices.blank'))
    end

    it 'user sees server validation errors' do
      within '#new_review' do
        fill_in 'review[title]', with: values[:invalid][:long]
        fill_in 'review[body]', with: values[:invalid][:long]
        select rand(1..5), from: 'review[rating]'

        click_button(I18n.t('review.post'))
      end

      title_error = I18n.t('errors.format', attribute: :Title,
                                            message: I18n.t('errors.messages.too_long.other',
                                                            count: Review::Contract::Create::TITLE_LENGTH))

      body_error = I18n.t('errors.format', attribute: :Body,
                                           message: I18n.t('errors.messages.too_long.other',
                                                           count: Review::Contract::Create::BODY_LENGTH))

      expect(page).to have_content(title_error)
      expect(page).to have_content(body_error)
    end
  end
end
