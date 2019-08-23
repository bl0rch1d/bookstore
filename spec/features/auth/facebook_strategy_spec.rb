describe 'Facebook strategy', type: :feature do
  before do
    visit root_path

    click_link(I18n.t('store.menu.my_account'))
    click_link(I18n.t('auth.log_in'))
  end

  it 'with valid credentials' do
    valid_facebook_login_setup

    first('.fa-facebook-official').click

    expect(page).to have_current_path root_path
    expect(page).not_to have_content(I18n.t('notices.facebook.error'))
    expect(page).not_to have_content(I18n.t('notices.facebook.error_authentication'))
  end

  it 'with invalid credentials' do
    invalid_facebook_login_setup

    first('.fa-facebook-official').click

    expect(page).to have_content(I18n.t('notices.facebook.error_authentication'))
  end

  it 'when with out credentials' do
    with_out_credentials_facebook_login_setup

    first('.fa-facebook-official').click

    expect(page).to have_content(I18n.t('notices.facebook.error'))
  end
end
