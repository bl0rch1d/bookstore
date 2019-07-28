require_relative 'feature_spec_helper'

RSpec.describe 'User page', type: :feature do
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
      visit settings_path
    end

    it 'can set/update billing address' do
      fill_in 'user[billing_address_attributes][first_name]', with: 'sometext'
      fill_in 'user[billing_address_attributes][last_name]',  with: 'sometext'
      fill_in 'user[billing_address_attributes][address]',    with: 'sometext'
      fill_in 'user[billing_address_attributes][city]',       with: 'sometext'
      fill_in 'user[billing_address_attributes][zip]',        with: '32323'
      fill_in 'user[billing_address_attributes][phone]',      with: '+32323'

      find('#billingSave').click

      expect(page).to have_content('Addresses has been updated')
    end

    it 'can set/update shipping address' do
      fill_in 'user[shipping_address_attributes][first_name]', with: 'sometext'
      fill_in 'user[shipping_address_attributes][last_name]',  with: 'sometext'
      fill_in 'user[shipping_address_attributes][address]',    with: 'sometext'
      fill_in 'user[shipping_address_attributes][city]',       with: 'sometext'
      fill_in 'user[shipping_address_attributes][zip]',        with: '32323'
      fill_in 'user[shipping_address_attributes][phone]',      with: '+32323'

      find('#shippingSave').click

      expect(page).to have_content('Addresses has been updated')
    end
  end

  it 'can change password'

  it 'can change email'

  it 'can remove an account'

  it 'can fast registration'
end
