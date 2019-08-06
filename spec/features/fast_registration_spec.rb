RSpec.describe 'Fast registration', type: :feature do
  let(:values) do
    {
      valid: {
        email: 'qwerty@example.com'
      }
    }
  end

  context 'when user registering without password' do
    before do
      create :book

      visit root_path

      click_link(I18n.t('store.button.buy_now'))

      visit cart_index_path
    end

    it 'with valid email' do
      click_link(I18n.t('checkout.button'))

      expect(page).to have_current_path('/users/fast_new')

      within '#fastCreate' do
        fill_in 'user[email]',	with: values[:valid][:email]

        click_button(I18n.t('user.fast_auth.continue'))
      end

      expect(page).to have_content(I18n.t('auth.confirmation.not_confirmed'))

      # Because email delivered with delay
      sleep 1

      ctoken = ActionMailer::Base.deliveries.last.body.raw_source.match(/confirmation_token=[\w*-]+/)
      visit "/users/confirmation?#{ctoken}"
    end

    it 'gets notice if user already exists' do
      click_link(I18n.t('checkout.button'))

      expect(page).to have_current_path('/users/fast_new')

      create(:user, email: values[:valid][:email])

      within '#fastCreate' do
        fill_in 'user[email]',	with: values[:valid][:email]
        click_button(I18n.t('user.fast_auth.continue'))
      end

      expect(page).to have_content(I18n.t('auth.errors.email_taken'))
    end
  end
end
