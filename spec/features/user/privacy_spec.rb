describe 'Privacy page' do
  let(:values) do
    {
      valid: {
        email: 'valid_email@example.com',
        current_password: 'Password123',
        new_password: 'newPassword1',
        confirm_password: 'newPassword1'
      },
      invalid: {
        blank: ''
      }
    }
  end

  context 'when user authorized' do
    before do
      login_as(create(:user, password: values[:valid][:current_password]), scope: :user)
      visit edit_user_registration_path
    end

    context 'when change email' do
      it 'can change email' do
        fill_in 'user[email]', with: values[:valid][:email]

        find('#emailSave').click

        expect(page).to have_content(I18n.t('devise.registrations.updated'))
      end

      it 'get validation errors' do
        fill_in 'user[email]', with: values[:invalid][:blank]

        find('#emailSave').click

        expect(page).to have_content(I18n.t('errors.messages.blank'))
      end
    end

    context 'when change password' do
      it 'can change password' do
        fill_in 'user[current_password]', with: values[:valid][:current_password]
        fill_in 'user[new_password]',     with: values[:valid][:new_password]
        fill_in 'user[confirm_password]', with: values[:valid][:confirm_password]

        find('#passwordSave').click

        expect(page).to have_content(I18n.t('devise.registrations.updated'))
      end

      it 'get validation errors' do
        fill_in 'user[new_password]',     with: values[:valid][:new_password]
        fill_in 'user[confirm_password]', with: values[:valid][:confirm_password]

        find('#passwordSave').click

        expect(page).to have_content(I18n.t('errors.messages.blank'))
      end
    end

    it 'can remove an account' do
      check I18n.t('user.remove_account.confirmation'), allow_label_click: true

      click_button(I18n.t('user.remove_account.remove'))
    end
  end

  context 'when user not authirzed' do
    it 'redirects user to root with flash message' do
      visit edit_addresses_path

      expect(page).to have_content(I18n.t('auth.errors.not_authorized'))
    end
  end
end
