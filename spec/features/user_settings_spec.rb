require_relative '../support/helpers/feature_spec_helper'

RSpec.describe 'User settings page', type: :feature do
  let(:values) do
    {
      valid: {
        first_name: 'First',
        last_name: 'Last',
        address: 'Address Line',
        city: 'Detroit',
        zip: '1234',
        phone: '+380638567656',
        number: '1234123412341234',
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

  before do
    register_user
    sign_in_user

    create(:order, :full, user: User.last)
  end

  it 'can view orders' do
    visit orders_path(sort_by: I18n.t('categories.all').downcase)

    expect(page).to have_content("##{Order.last.number}")
  end

  it 'can view detailed infomation about order' do
    visit orders_path(sort_by: I18n.t('categories.all').downcase)

    find('.general-order-number').click

    order = Order.last

    expect(page).to have_content(order.billing_address.first_name)
    expect(page).to have_content(order.shipping_address.first_name)
    expect(page).to have_content(order.shipping_method.title)
    expect(page).to have_content(order.credit_card.expiration_date)

    expect(page).to have_content(order.order_items.sample.book.title)
  end

  context 'when billing and shipping addresses' do
    before do
      visit edit_addresses_path
    end

    it 'can set/update billing address' do
      fill_in 'user[billing_address_attributes][first_name]',   with: values[:valid][:first_name]
      fill_in 'user[billing_address_attributes][last_name]',    with: values[:valid][:last_name]
      fill_in 'user[billing_address_attributes][address_line]', with: values[:valid][:address]
      fill_in 'user[billing_address_attributes][city]',         with: values[:valid][:city]
      fill_in 'user[billing_address_attributes][zip]',          with: values[:valid][:zip]
      fill_in 'user[billing_address_attributes][phone]',        with: values[:valid][:phone]

      find('#user_billing_address_attributes_country').find(:xpath, 'option[2]').select_option

      find('#billingSave').click

      expect(page).to have_content(I18n.t('user.notice.address_updated'))
    end

    it 'can set/update shipping address' do
      fill_in 'user[shipping_address_attributes][first_name]',    with: values[:valid][:first_name]
      fill_in 'user[shipping_address_attributes][last_name]',     with: values[:valid][:last_name]
      fill_in 'user[shipping_address_attributes][address_line]',  with: values[:valid][:address]
      fill_in 'user[shipping_address_attributes][city]',          with: values[:valid][:city]
      fill_in 'user[shipping_address_attributes][zip]',           with: values[:valid][:zip]
      fill_in 'user[shipping_address_attributes][phone]',         with: values[:valid][:phone]

      find('#user_shipping_address_attributes_country').find(:xpath, 'option[2]').select_option

      find('#shippingSave').click

      expect(page).to have_content(I18n.t('user.notice.address_updated'))
    end

    it 'get valiadteion errors' do
      find('#shippingSave').click

      expect(page).to have_content(I18n.t('errors.messages.blank'), count: 7)
    end
  end

  context 'when change email' do
    before do
      visit edit_user_registration_path
    end

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
    before do
      visit edit_user_registration_path
    end

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
    visit edit_user_registration_path

    check I18n.t('user.remove_account.confirmation'), allow_label_click: true

    click_button(I18n.t('user.remove_account.remove'))
  end
end
