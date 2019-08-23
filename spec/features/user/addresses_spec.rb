describe 'Addressess page' do
  let(:values) do
    {
      valid: {
        first_name: 'First',
        last_name: 'Last',
        address_line: 'Address Line',
        city: 'Detroit',
        zip: '1234',
        phone: '+380638567656'
      }
    }
  end

  context 'when billing and shipping addresses' do
    before do
      login_as(create(:user), scope: :user)
      visit edit_addresses_path
    end

    it 'user can set/update billing address' do
      values[:valid].each do |key, value|
        fill_in "user[billing_address_attributes][#{key}]", with: value
      end

      find('#user_billing_address_attributes_country').find(:xpath, 'option[2]').select_option

      find('#billingSave').click

      expect(page).to have_content(I18n.t('user.notice.address_updated'))
    end

    it 'user can set/update shipping address' do
      values[:valid].each do |key, value|
        fill_in "user[shipping_address_attributes][#{key}]", with: value
      end

      find('#user_shipping_address_attributes_country').find(:xpath, 'option[2]').select_option

      find('#shippingSave').click

      expect(page).to have_content(I18n.t('user.notice.address_updated'))
    end

    it 'user can see valiadteion errors' do
      find('#shippingSave').click

      expect(page).to have_content(I18n.t('errors.messages.blank'), count: 7)
    end
  end

  context 'when user not authirzed' do
    it 'redirects user to root with flash message' do
      visit edit_addresses_path

      expect(page).to have_content(I18n.t('auth.errors.not_authorized'))
    end
  end
end
