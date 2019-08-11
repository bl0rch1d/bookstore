describe 'Checkout', type: :feature do
  let!(:shipping_method) { create(:shipping_method) }

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
        card_name: 'Name Of Card',
        expiration_date: '12/21',
        cvv: Array.new(rand(3..4)) { rand(1..9) }.join,
        secure_number: '** ** ** 1234'
      },
      invalid: {
        blank: 32.chr
      }
    }
  end

  let(:user) { create(:user) }

  # rubocop:disable MultipleExpectations, ExampleLength
  context 'when success' do
    before do
      create_list(:book, 1)
      visit root_path
      click_link(I18n.t('store.button.buy_now'))
      login_as(user, scope: :user)
      visit order_order_items_path(Order.last)
    end

    it 'User can buy book through checkout flow' do
      click_link(I18n.t('checkout.button'))

      expect(page).to have_current_path(checkout_step_path(:address))

      within '.edit_order' do
        fill_in 'order[billing_address][first_name]',   with: values[:valid][:first_name]
        fill_in 'order[billing_address][last_name]',    with: values[:valid][:last_name]
        fill_in 'order[billing_address][address_line]', with: values[:valid][:address]
        fill_in 'order[billing_address][city]',         with: values[:valid][:city]
        fill_in 'order[billing_address][zip]',          with: values[:valid][:zip]
        fill_in 'order[billing_address][phone]',        with: values[:valid][:phone]
        find('#order_billing_address_country').find(:xpath, 'option[2]').select_option

        fill_in 'order[shipping_address][first_name]',    with: values[:valid][:first_name]
        fill_in 'order[shipping_address][last_name]',     with: values[:valid][:last_name]
        fill_in 'order[shipping_address][address_line]',  with: values[:valid][:address]
        fill_in 'order[shipping_address][city]',          with: values[:valid][:city]
        fill_in 'order[shipping_address][zip]',           with: values[:valid][:zip]
        fill_in 'order[shipping_address][phone]',         with: values[:valid][:phone]
        find('#order_shipping_address_country').find(:xpath, 'option[2]').select_option

        find('input[type="submit"]').click
      end

      expect(page).to have_current_path(checkout_step_path(:shipping))

      within '.edit_order' do
        find('.radio-text', text: shipping_method.title).click

        find('input[type="submit"]').click
      end

      expect(page).to have_current_path(checkout_step_path(:payment))

      within '.edit_order' do
        fill_in 'order[credit_card][number]',           with: values[:valid][:number]
        fill_in 'order[credit_card][card_name]',        with: values[:valid][:card_name]
        fill_in 'order[credit_card][expiration_date]',  with: values[:valid][:expiration_date]
        fill_in 'order[credit_card][cvv]',              with: values[:valid][:cvv]

        find('input[type="submit"]').click
      end

      expect(page).to have_current_path(checkout_step_path(:confirm))

      expect(page).to have_content(OrderItem.last.book.title)
      expect(page).to have_content(ShippingMethod.last.title)
      expect(page).to have_content(values[:valid][:secure_number])

      click_button(I18n.t('form.place_order'))

      expect(page).to have_current_path(checkout_step_path(:complete))
      expect(page).to have_content(OrderItem.last.book.title)
      expect(page).to have_content(I18n.t('checkout.thanks'))

      click_button(I18n.t('checkout.back'))

      expect(page).to have_current_path(books_path)
    end

    it 'User can buy book through checkout flow user only billing_address' do
      click_link(I18n.t('checkout.button'))

      expect(page).to have_current_path(checkout_step_path(:address))

      within '.edit_order' do
        fill_in 'order[billing_address][first_name]',   with: values[:valid][:first_name]
        fill_in 'order[billing_address][last_name]',    with: values[:valid][:last_name]
        fill_in 'order[billing_address][address_line]', with: values[:valid][:address]
        fill_in 'order[billing_address][city]',         with: values[:valid][:city]
        fill_in 'order[billing_address][zip]',          with: values[:valid][:zip]
        fill_in 'order[billing_address][phone]',        with: values[:valid][:phone]
        find('#order_billing_address_country').find(:xpath, 'option[2]').select_option

        check I18n.t('address.use_billing'), allow_label_click: true

        find('input[type="submit"]').click
      end

      expect(page).to have_current_path(checkout_step_path(:shipping))

      within '.edit_order' do
        find('.radio-text', text: shipping_method.title).click

        find('input[type="submit"]').click
      end

      expect(page).to have_current_path(checkout_step_path(:payment))

      within '.edit_order' do
        fill_in 'order[credit_card][number]',           with: values[:valid][:number]
        fill_in 'order[credit_card][card_name]',        with: values[:valid][:card_name]
        fill_in 'order[credit_card][expiration_date]',  with: values[:valid][:expiration_date]
        fill_in 'order[credit_card][cvv]',              with: values[:valid][:cvv]

        find('input[type="submit"]').click
      end

      expect(page).to have_current_path(checkout_step_path(:confirm))

      expect(page).to have_content(OrderItem.last.book.title)
      expect(page).to have_content(ShippingMethod.last.title)
      expect(page).to have_content(values[:valid][:secure_number])

      click_button(I18n.t('form.place_order'))

      expect(page).to have_current_path(checkout_step_path(:complete))
      expect(page).to have_content(OrderItem.last.book.title)
      expect(page).to have_content(I18n.t('checkout.thanks'))

      click_button(I18n.t('checkout.back'))

      expect(page).to have_current_path(books_path)
    end

    context 'when user reloads page at complete step' do
      let(:order) { create(:order, :at_complete_step, user: user) }

      before do
        page.set_rack_session(current_order_id: order.id)
        visit checkout_step_path(:complete)
      end

      it 'redirect to order page' do
        page.driver.browser.navigate.refresh

        expect(page).to have_current_path("/users/#{user.id}/orders/#{order.id}")
      end
    end
  end

  context 'when failure' do
    before do
      create(:book)
      login_as(user, scope: :user)
    end

    it 'User redirects if checkout step not allowed' do
      visit checkout_step_path(:address)

      expect(page).to have_current_path(root_path)

      click_link(I18n.t('store.button.buy_now'))

      visit checkout_step_path(:payment)

      expect(page).to have_current_path(checkout_step_path(:address))
    end

    context 'when validation errors' do
      it 'User see adddress validation errors' do
        create(:order, :at_address_step, user: user)
        page.set_rack_session(current_order_id: Order.last.id)

        visit checkout_step_path(:address)

        expect(page).to have_current_path(checkout_step_path(:address))

        within '.edit_order' do
          fill_in 'order[billing_address][first_name]',   with: values[:invalid][:blank]
          fill_in 'order[billing_address][last_name]',    with: values[:invalid][:blank]
          fill_in 'order[billing_address][address_line]', with: values[:invalid][:blank]
          fill_in 'order[billing_address][city]',         with: values[:invalid][:blank]
          fill_in 'order[billing_address][zip]',          with: values[:invalid][:blank]
          fill_in 'order[billing_address][phone]',        with: values[:invalid][:blank]

          check I18n.t('address.use_billing'), allow_label_click: true

          find('input[type="submit"]').click
        end

        expect(all('span.help-block').size).to eq(14)
      end

      it 'User see shipping method validation errors' do
        create(:order, :at_shipping_step, user: user)
        page.set_rack_session(current_order_id: Order.last.id)

        visit checkout_step_path(:shipping)

        expect(page).to have_current_path(checkout_step_path(:shipping))

        within '.edit_order' do
          find('input[type="submit"]').click
        end

        expect(page).to have_current_path(checkout_step_path(:shipping))
        expect(page).to have_content(
          I18n.t('errors.format', attribute: :"Shipping method", message: I18n.t('errors.messages.blank'))
        )
      end

      it 'User see credit card validation errors' do
        create(:order, :at_payment_step, user: user)
        page.set_rack_session(current_order_id: Order.last.id)

        visit checkout_step_path(:payment)

        expect(page).to have_current_path(checkout_step_path(:payment))

        within '.edit_order' do
          fill_in 'order[credit_card][number]',           with: values[:invalid][:blank]
          fill_in 'order[credit_card][card_name]',        with: values[:invalid][:blank]
          fill_in 'order[credit_card][expiration_date]',  with: values[:invalid][:blank]
          fill_in 'order[credit_card][cvv]',              with: values[:invalid][:blank]

          find('input[type="submit"]').click
        end

        expect(page).to have_current_path(checkout_step_path(:payment))
        expect(all('span.help-block').size).to eq(4)
      end
    end
  end
  # rubocop:enable MultipleExpectations, ExampleLength
end
