# require_relative '../support/helpers/feature_spec_helper'

# === TODO ===
# describe 'Checkout', type: :feature do
#   let!(:shipping_method) { create(:shipping_method) }

#   let(:values) do
#     {
#       valid: {
#         first_name: 'First',
#         last_name: 'Last',
#         address: 'Address Line',
#         city: 'Detroit',
#         zip: '1234',
#         phone: '+380638567656',
#         number: '1234123412341234',
#         card_name: 'Name Of Card',
#         expiration_date: '12/21',
#         cvv: Array.new(rand(3..4)) { rand(1..9) }.join,
#         secure_number: '** ** ** 1234'
#       },
#       invalid: {
#         blank: ''
#       }
#     }
#   end

#   before do
#     create_list(:book, 20)
#   end

#   context 'when success' do
#     it 'User can buy book through checkout flow' do
#       visit root_path

#       click_link(I18n.t('store.button.buy_now'))

#       register_user
#       sign_in_user

#       visit cart_index_path

#       click_link(I18n.t('checkout.button'))

#       expect(page).to have_current_path('/checkout_steps/address')

#       within '.edit_order' do
#         fill_in 'order[billing_address][first_name]',   with: values[:valid][:first_name]
#         fill_in 'order[billing_address][last_name]',    with: values[:valid][:last_name]
#         fill_in 'order[billing_address][address_line]', with: values[:valid][:address]
#         fill_in 'order[billing_address][city]',         with: values[:valid][:city]
#         fill_in 'order[billing_address][zip]',          with: values[:valid][:zip]
#         fill_in 'order[billing_address][phone]',        with: values[:valid][:phone]
#         find('#order_billing_address_country').find(:xpath, 'option[2]').select_option

#         fill_in 'order[shipping_address][first_name]',    with: values[:valid][:first_name]
#         fill_in 'order[shipping_address][last_name]',     with: values[:valid][:last_name]
#         fill_in 'order[shipping_address][address_line]',  with: values[:valid][:address]
#         fill_in 'order[shipping_address][city]',          with: values[:valid][:city]
#         fill_in 'order[shipping_address][zip]',           with: values[:valid][:zip]
#         fill_in 'order[shipping_address][phone]',         with: values[:valid][:phone]
#         find('#order_shipping_address_country').find(:xpath, 'option[2]').select_option

#         find('input[type="submit"]').click
#       end

#       expect(page).to have_current_path('/checkout_steps/shipping')

#       within '.edit_order' do
#         find('.radio-text', text: shipping_method.title).click

#         find('input[type="submit"]').click
#       end

#       expect(page).to have_current_path('/checkout_steps/payment')

#       within '.edit_order' do
#         fill_in 'order[credit_card][number]',           with: values[:valid][:number]
#         fill_in 'order[credit_card][card_name]',        with: values[:valid][:card_name]
#         fill_in 'order[credit_card][expiration_date]',  with: values[:valid][:expiration_date]
#         fill_in 'order[credit_card][cvv]',              with: values[:valid][:cvv]

#         find('input[type="submit"]').click
#       end

#       expect(page).to have_current_path('/checkout_steps/confirm')

#       expect(page).to have_content(OrderItem.last.book.title)
#       expect(page).to have_content(ShippingMethod.last.title)
#       expect(page).to have_content(values[:valid][:secure_number])

#       click_button(I18n.t('form.place_order'))

#       expect(page).to have_current_path('/checkout_steps/complete')
#       expect(page).to have_content(OrderItem.last.book.title)
#       expect(page).to have_content(I18n.t('checkout.thanks'))

#       click_button(I18n.t('checkout.back'))

#       expect(page).to have_current_path(books_path)
#     end

#     it 'User can buy book through checkout flow user only billing_address' do
#       visit root_path

#       click_link(I18n.t('store.button.buy_now'))

#       register_user
#       sign_in_user

#       visit cart_index_path

#       click_link(I18n.t('checkout.button'))

#       expect(page).to have_current_path('/checkout_steps/address')

#       within '.edit_order' do
#         fill_in 'order[billing_address][first_name]',   with: values[:valid][:first_name]
#         fill_in 'order[billing_address][last_name]',    with: values[:valid][:last_name]
#         fill_in 'order[billing_address][address_line]', with: values[:valid][:address]
#         fill_in 'order[billing_address][city]',         with: values[:valid][:city]
#         fill_in 'order[billing_address][zip]',          with: values[:valid][:zip]
#         fill_in 'order[billing_address][phone]',        with: values[:valid][:phone]
#         find('#order_billing_address_country').find(:xpath, 'option[2]').select_option

#         check I18n.t('address.use_billing'), allow_label_click: true

#         find('input[type="submit"]').click
#       end

#       expect(page).to have_current_path('/checkout_steps/shipping')

#       within '.edit_order' do
#         find('.radio-text', text: shipping_method.title).click

#         find('input[type="submit"]').click
#       end

#       expect(page).to have_current_path('/checkout_steps/payment')

#       within '.edit_order' do
#         fill_in 'order[credit_card][number]',           with: values[:valid][:number]
#         fill_in 'order[credit_card][card_name]',        with: values[:valid][:card_name]
#         fill_in 'order[credit_card][expiration_date]',  with: values[:valid][:expiration_date]
#         fill_in 'order[credit_card][cvv]',              with: values[:valid][:cvv]

#         find('input[type="submit"]').click
#       end

#       expect(page).to have_current_path('/checkout_steps/confirm')

#       expect(page).to have_content(OrderItem.last.book.title)
#       expect(page).to have_content(ShippingMethod.last.title)
#       expect(page).to have_content(values[:valid][:secure_number])

#       click_button(I18n.t('form.place_order'))

#       expect(page).to have_current_path('/checkout_steps/complete')
#       expect(page).to have_content(OrderItem.last.book.title)
#       expect(page).to have_content(I18n.t('checkout.thanks'))

#       click_button(I18n.t('checkout.back'))

#       expect(page).to have_current_path(books_path)
#     end
#   end

#   context 'when failure' do
#     before do
#       register_user
#       sign_in_user
#     end

#     it 'User redirects if checkout step not allowed' do
#       visit checkout_step_path(:address)

#       expect(page).to have_current_path('/')

#       click_link(I18n.t('store.button.buy_now'))

#       visit checkout_step_path(:payment)

#       expect(page).to have_current_path('/')
#     end

#     it 'User see adddress validation errors' do
#       visit root_path

#       click_link(I18n.t('store.button.buy_now'))

#       visit cart_index_path

#       click_link(I18n.t('checkout.button'))

#       expect(page).to have_current_path('/checkout_steps/address')

#       within '.edit_order' do
#         fill_in 'order[billing_address][first_name]',   with: values[:invalid][:blank]
#         fill_in 'order[billing_address][last_name]',    with: values[:invalid][:blank]
#         fill_in 'order[billing_address][address_line]', with: values[:invalid][:blank]
#         fill_in 'order[billing_address][city]',         with: values[:invalid][:blank]
#         fill_in 'order[billing_address][zip]',          with: values[:invalid][:blank]
#         fill_in 'order[billing_address][phone]',        with: values[:invalid][:blank]

#         check I18n.t('address.use_billing'), allow_label_click: true

#         find('input[type="submit"]').click
#       end

#       expect(all('span.help-block').size).to eq(14)
#     end

#     it 'User see shipping method validation errors' do
#       visit root_path

#       click_link(I18n.t('store.button.buy_now'))

#       visit cart_index_path

#       click_link(I18n.t('checkout.button'))

#       expect(page).to have_current_path('/checkout_steps/address')

#       within '.edit_order' do
#         fill_in 'order[billing_address][first_name]',   with: values[:valid][:first_name]
#         fill_in 'order[billing_address][last_name]',    with: values[:valid][:last_name]
#         fill_in 'order[billing_address][address_line]', with: values[:valid][:address]
#         fill_in 'order[billing_address][city]',         with: values[:valid][:city]
#         fill_in 'order[billing_address][zip]',          with: values[:valid][:zip]
#         fill_in 'order[billing_address][phone]',        with: values[:valid][:phone]
#         find('#order_billing_address_country').find(:xpath, 'option[2]').select_option

#         check I18n.t('address.use_billing'), allow_label_click: true

#         find('input[type="submit"]').click
#       end

#       expect(page).to have_current_path('/checkout_steps/shipping')

#       within '.edit_order' do
#         find('input[type="submit"]').click
#       end

#       expect(page).to have_current_path('/checkout_steps/shipping')
#       expect(page).to have_content(
#         I18n.t('errors.format', attribute: :"Shipping method", message: I18n.t('errors.messages.blank'))
#       )
#     end

#     it 'User see credit card validation errors' do
#       visit root_path

#       click_link(I18n.t('store.button.buy_now'))

#       visit cart_index_path

#       click_link(I18n.t('checkout.button'))

#       expect(page).to have_current_path('/checkout_steps/address')

#       within '.edit_order' do
#         fill_in 'order[billing_address][first_name]',   with: values[:valid][:first_name]
#         fill_in 'order[billing_address][last_name]',    with: values[:valid][:last_name]
#         fill_in 'order[billing_address][address_line]', with: values[:valid][:address]
#         fill_in 'order[billing_address][city]',         with: values[:valid][:city]
#         fill_in 'order[billing_address][zip]',          with: values[:valid][:zip]
#         fill_in 'order[billing_address][phone]',        with: values[:valid][:phone]
#         find('#order_billing_address_country').find(:xpath, 'option[2]').select_option

#         check I18n.t('address.use_billing'), allow_label_click: true

#         find('input[type="submit"]').click
#       end

#       expect(page).to have_current_path('/checkout_steps/shipping')

#       within '.edit_order' do
#         find('.radio-text', text: shipping_method.title).click

#         find('input[type="submit"]').click
#       end

#       expect(page).to have_current_path('/checkout_steps/payment')

#       within '.edit_order' do
#         fill_in 'order[credit_card][number]',           with: values[:invalid][:blank]
#         fill_in 'order[credit_card][card_name]',        with: values[:invalid][:blank]
#         fill_in 'order[credit_card][expiration_date]',  with: values[:invalid][:blank]
#         fill_in 'order[credit_card][cvv]',              with: values[:invalid][:blank]

#         find('input[type="submit"]').click
#       end

#       expect(page).to have_current_path('/checkout_steps/payment')
#       expect(all('span.help-block').size).to eq(4)
#     end
#   end
# end
# rubocop: enable RSpec/MultipleExpectations, RSpec/ExampleLength
