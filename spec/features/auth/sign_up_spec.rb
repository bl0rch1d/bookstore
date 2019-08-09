describe 'Sign up', type: :feature do
  let(:user) { create(:user) }

  context 'when user can sign up' do
    let(:password) { 'Password123' }

    before do
      visit root_path

      click_link(I18n.t('store.menu.my_account'))
      click_link(I18n.t('auth.sign_up'))
    end

    context 'with valid params' do
      before do
        within '#new_user' do
          fill_in 'user[email]',                  with: FFaker::Internet.email
          fill_in 'user[password]',               with: password
          fill_in 'user[password_confirmation]',  with: password

          click_button I18n.t('auth.sign_up')
        end
      end

      it 'successful redirect with confirmation notice' do
        expect(page).to have_current_path root_path
        expect(page).to have_content(I18n.t('devise.registrations.signed_up_but_unconfirmed'))
      end
    end

    context 'with invalid params' do
      let(:invalid_email) { 'ddd' }
      let(:incomplete_email) { 'ddd@' }

      it 'blank email' do
        fill_in 'user[email]',                  with: ''
        fill_in 'user[password]',               with: password
        fill_in 'user[password_confirmation]',  with: password

        click_button I18n.t('auth.sign_up')

        message = find('#user_email').native.attribute('validationMessage')

        expect(message).to match(I18n.t('validation_notices.blank'))
      end

      it 'invalid email' do
        fill_in 'user[email]',                  with: invalid_email
        fill_in 'user[password]',               with: password
        fill_in 'user[password_confirmation]',  with: password

        click_button I18n.t('auth.sign_up')

        message = find('#user_email').native.attribute('validationMessage')

        expect(message).to match(I18n.t('validation_notices.invalid_format', value: invalid_email))
      end

      it 'incomplete email' do
        fill_in 'user[email]',                  with: incomplete_email
        fill_in 'user[password]',               with: password
        fill_in 'user[password_confirmation]',  with: password

        click_button I18n.t('auth.sign_up')

        message = find('#user_email').native.attribute('validationMessage')

        expect(message).to match(I18n.t('validation_notices.incomplete_format', value: incomplete_email))
      end
    end
  end
end
