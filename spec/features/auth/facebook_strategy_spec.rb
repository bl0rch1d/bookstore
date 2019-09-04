describe 'Facebook strategy', type: :feature do
  before do
    visit root_path

    click_link(I18n.t('store.menu.my_account'))
    click_link(I18n.t('auth.log_in'))
  end

  context 'with valid credentials' do
    it do
      valid_facebook_login_setup

      first('.fa-facebook-official').click

      expect(page).to have_current_path root_path
      expect(page).not_to have_content(I18n.t('notices.facebook.error'))
      expect(page).not_to have_content(I18n.t('notices.facebook.error_authentication'))
    end

    context 'when user already registered' do
      let!(:user) { create(:user) }

      it do
        valid_facebook_login_setup(email: user.email)

        first('.fa-facebook-official').click

        expect(page).to have_current_path root_path
        expect(page).not_to have_content(I18n.t('notices.facebook.error'))
        expect(page).not_to have_content(I18n.t('notices.facebook.error_authentication'))
      end
    end
  end

  it 'with invalid credentials' do
    invalid_facebook_login_setup

    first('.fa-facebook-official').click

    expect(page).to have_content(I18n.t('notices.facebook.error_authentication'))
  end

  it 'when without credentials' do
    without_credentials_facebook_login_setup

    first('.fa-facebook-official').click

    expect(page).to have_content(I18n.t('notices.facebook.error'))
  end
end
