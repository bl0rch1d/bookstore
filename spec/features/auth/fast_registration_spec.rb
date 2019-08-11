describe 'Fast registration', type: :feature do
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

      visit order_order_items_path(Order.last)
    end

    context 'with valid email' do
      it 'register user and redirec it to heckout Address step' do
        click_link(I18n.t('checkout.button'))

        expect(page).to have_current_path(users_fast_new_path)

        within '#fastCreate' do
          fill_in 'user[email]', with: values[:valid][:email]

          click_button(I18n.t('user.fast_auth.continue'))
        end

        expect(page).to have_content(I18n.t('auth.confirmation.not_confirmed'))

        # Because email delivered with delay
        sleep 0.5

        confirmation_mail = ActionMailer::Base.deliveries.select do |mail|
          mail.subject == 'Confirmation instructions' && mail.to[0] == values[:valid][:email]
        end

        ctoken = confirmation_mail[0].body.raw_source.match(/confirmation_token=[\w*-]+/)

        visit "/users/confirmation?#{ctoken}"

        sleep 1

        expect(page).to have_current_path(checkout_step_path(:address))
      end
    end

    it 'gets notice if user already exists' do
      click_link(I18n.t('checkout.button'))

      expect(page).to have_current_path(users_fast_new_path)

      create(:user, email: values[:valid][:email])

      within '#fastCreate' do
        fill_in 'user[email]', with: values[:valid][:email]
        click_button(I18n.t('user.fast_auth.continue'))
      end

      expect(page).to have_content(I18n.t('auth.errors.email_taken'))
    end
  end
end