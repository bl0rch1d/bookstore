# describe 'User addresses page' do
#   context 'when billing and shipping addresses' do
#     before do
#       visit edit_addresses_path
#     end

#     it 'user can set/update billing address' do
#       fill_in 'user[billing_address_attributes][first_name]',   with: values[:valid][:first_name]
#       fill_in 'user[billing_address_attributes][last_name]',    with: values[:valid][:last_name]
#       fill_in 'user[billing_address_attributes][address_line]', with: values[:valid][:address]
#       fill_in 'user[billing_address_attributes][city]',         with: values[:valid][:city]
#       fill_in 'user[billing_address_attributes][zip]',          with: values[:valid][:zip]
#       fill_in 'user[billing_address_attributes][phone]',        with: values[:valid][:phone]

#       find('#user_billing_address_attributes_country').find(:xpath, 'option[2]').select_option

#       find('#billingSave').click

#       expect(page).to have_content(I18n.t('user.notice.address_updated'))
#     end

#     it 'user can set/update shipping address' do
#       fill_in 'user[shipping_address_attributes][first_name]',    with: values[:valid][:first_name]
#       fill_in 'user[shipping_address_attributes][last_name]',     with: values[:valid][:last_name]
#       fill_in 'user[shipping_address_attributes][address_line]',  with: values[:valid][:address]
#       fill_in 'user[shipping_address_attributes][city]',          with: values[:valid][:city]
#       fill_in 'user[shipping_address_attributes][zip]',           with: values[:valid][:zip]
#       fill_in 'user[shipping_address_attributes][phone]',         with: values[:valid][:phone]

#       find('#user_shipping_address_attributes_country').find(:xpath, 'option[2]').select_option

#       find('#shippingSave').click

#       expect(page).to have_content(I18n.t('user.notice.address_updated'))
#     end

#     it 'user can see valiadteion errors' do
#       find('#shippingSave').click

#       expect(page).to have_content(I18n.t('errors.messages.blank'), count: 7)
#     end
#   end
# end
