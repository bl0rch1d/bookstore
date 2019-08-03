require_relative 'feature_spec_helper'

RSpec.describe 'User settings page', type: :feature do
  before do
    register_user
    sign_in_user

    create(:order, :full, user: User.last)
  end

  it 'can view orders' do
    visit orders_path(sort_by: 'all')

    expect(page).to have_content("##{Order.last.number}")
  end

  it 'can view detailed infomation about order' do
    visit orders_path(sort_by: 'all')

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
      fill_in 'user[billing_address_attributes][first_name]',   with: 'sometext'
      fill_in 'user[billing_address_attributes][last_name]',    with: 'sometext'
      fill_in 'user[billing_address_attributes][address_line]', with: 'sometext'
      fill_in 'user[billing_address_attributes][city]',         with: 'sometext'
      fill_in 'user[billing_address_attributes][zip]',          with: '32323'
      fill_in 'user[billing_address_attributes][phone]',        with: '+32323'

      find('#user_billing_address_attributes_country').find(:xpath, 'option[2]').select_option

      find('#billingSave').click

      expect(page).to have_content('Addresses has been updated')
    end

    it 'can set/update shipping address' do
      fill_in 'user[shipping_address_attributes][first_name]',    with: 'sometext'
      fill_in 'user[shipping_address_attributes][last_name]',     with: 'sometext'
      fill_in 'user[shipping_address_attributes][address_line]',  with: 'sometext'
      fill_in 'user[shipping_address_attributes][city]',          with: 'sometext'
      fill_in 'user[shipping_address_attributes][zip]',           with: '32323'
      fill_in 'user[shipping_address_attributes][phone]',         with: '+32323'

      find('#user_shipping_address_attributes_country').find(:xpath, 'option[2]').select_option

      find('#shippingSave').click

      expect(page).to have_content('Addresses has been updated')
    end

    it 'get valiadteion errors' do
      find('#shippingSave').click

      expect(page).to have_content("can't be blank", count: 7)
    end
  end

  context 'when change email' do
    before do
      visit edit_user_registration_path
    end

    it 'can change email' do
      fill_in 'user[email]', with: 'newemail@example.com'

      find('#emailSave').click

      expect(page).to have_content(I18n.t('devise.registrations.updated'))
    end

    it 'get validation errors' do
      fill_in 'user[email]', with: ''

      find('#emailSave').click

      expect(page).to have_content("can't be blank")
    end
  end

  context 'when change password' do
    before do
      visit edit_user_registration_path
    end

    it 'can change password' do
      fill_in 'user[current_password]', with: 'Password123'
      fill_in 'user[new_password]',     with: 'NewPassword123'
      fill_in 'user[confirm_password]', with: 'NewPassword123'

      find('#passwordSave').click

      expect(page).to have_content(I18n.t('devise.registrations.updated'))
    end

    it 'get validation errors' do
      fill_in 'user[new_password]',     with: 'NewPassword123'
      fill_in 'user[confirm_password]', with: 'NewPassword123'

      find('#passwordSave').click

      expect(page).to have_content("can't be blank")
    end
  end

  it 'can remove an account' do
    visit edit_user_registration_path

    check 'I understand that all data will be lost', allow_label_click: true

    click_button('Please Remove My Account')
  end
end
