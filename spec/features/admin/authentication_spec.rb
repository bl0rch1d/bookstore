describe 'Admin authentication' do
  let(:admin_user) { create(:admin_user) }

  it 'Admin can log in' do
    visit new_admin_user_session_path

    within '#session_new' do
      fill_in 'admin_user[email]',    with: admin_user.email
      fill_in 'admin_user[password]', with: admin_user.password

      click_button(I18n.t('admin.authentication.login'))
    end

    expect(page).to have_current_path(admin_root_path)
  end

  it 'Admin can log out' do
    login_as(admin_user, scope: :admin_user)

    visit admin_root_path

    click_link(I18n.t('admin.authentication.logout'))

    expect(page).to have_current_path(new_admin_user_session_path)
  end
end
