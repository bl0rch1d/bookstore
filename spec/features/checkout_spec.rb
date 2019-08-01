require_relative 'feature_spec_helper'

RSpec.describe 'Checkout', type: :feature do
  let!(:books) { create_list(:book, 20) }
  let!(:shipping_method) { create(:shipping_method) }

  it 'User can buy book through checkout flow' do
    visit root_path

    click_link('Buy Now')

    register_user
    sign_in_user

    visit cart_index_path

    click_link('Checkout')

    expect(page).to have_current_path('/checkout/address')

    within '.edit_order' do
      fill_in 'order[billing_address][first_name]', with: 'firstname'
      fill_in 'order[billing_address][last_name]',  with: 'lastname'
      fill_in 'order[billing_address][address]',    with: 'address'
      fill_in 'order[billing_address][city]',       with: 'city'
      fill_in 'order[billing_address][zip]',        with: 123
      fill_in 'order[billing_address][phone]',      with: '+380638567656'
      find('#order_billing_address_country').find(:xpath, 'option[2]').select_option

      fill_in 'order[shipping_address][first_name]',  with: 'test'
      fill_in 'order[shipping_address][last_name]',   with: 'test'
      fill_in 'order[shipping_address][address]',     with: 'test'
      fill_in 'order[shipping_address][city]',        with: 'test'
      fill_in 'order[shipping_address][zip]',         with: 123
      fill_in 'order[shipping_address][phone]',       with: '+380638567656'
      find('#order_shipping_address_country').find(:xpath, 'option[2]').select_option

      find('input[type="submit"]').click
    end

    expect(page).to have_current_path('/checkout/shipping')

    within '.edit_order' do
      find('.radio-text', text: shipping_method.title).click

      find('input[type="submit"]').click
    end

    expect(page).to have_current_path('/checkout/payment')

    within '.edit_order' do
      fill_in 'order[credit_card][number]',           with: '1234123412341234'
      fill_in 'order[credit_card][card_name]',        with: 'Card Owner'
      fill_in 'order[credit_card][expiration_date]',  with: '12/12'
      fill_in 'order[credit_card][cvv]',              with: '1234'

      find('input[type="submit"]').click
    end

    expect(page).to have_current_path('/checkout/confirm')

    expect(page).to have_content(OrderItem.last.book.title)
    expect(page).to have_content(ShippingMethod.last.title)
    expect(page).to have_content('** ** ** 1234')

    click_button('Place order')

    expect(page).to have_current_path('/checkout/complete')
    expect(page).to have_content(OrderItem.last.book.title)
    expect(page).to have_content('Thank You for your Order!')

    click_button('Back to Store')

    expect(page).to have_current_path(category_books_path(0))
  end
end
