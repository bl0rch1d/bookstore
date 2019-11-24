describe 'Sign in', type: :feature do
  let(:user) { create(:user) }

  context 'when user can sign in' do
    before do
      visit root_path

      click_link(I18n.t('store.menu.my_account'))
      click_link(I18n.t('auth.log_in'))
    end

    context 'with valid params' do
      before do
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        click_button I18n.t('auth.log_in')
      end

      it 'successful redirect' do
        expect(page).to have_current_path root_path
        expect(page).to have_content(I18n.t('devise.sessions.signed_in'))
      end

      it 'user can sign out' do
        click_link(I18n.t('store.menu.my_account'))
        click_link(I18n.t('auth.sign_out'))
        expect(page).to have_content(I18n.t('devise.sessions.signed_out'))
      end
    end

    context 'with invalid params' do
      let(:invalid_email) { FFaker::Internet.email }
      let(:invalid_key) { 'Email' }

      it 'user see validation errors' do
        fill_in 'user[email]', with: invalid_email
        fill_in 'user[password]', with: user.password
        click_button I18n.t('auth.log_in')

        expect(page).to have_content(I18n.t('devise.failure.not_found_in_database', authentication_keys: invalid_key))
      end
    end
  end
end
