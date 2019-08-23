describe 'Checkout', type: :feature do
  let!(:shipping_method) { create(:shipping_method) }

  let(:values) do
    {
      valid: {
        address: {
          first_name: 'First',
          last_name: 'Last',
          address_line: 'Address Line',
          city: 'Detroit',
          zip: '1234',
          phone: '+380638567656'
        },

        credit_card: {
          number: '1234123412341234',
          card_name: 'Name Of Card',
          expiration_date: '12/21',
          cvv: Array.new(rand(3..4)) { rand(1..9) }.join
        },

        secure_number: '** ** ** 1234'
      },
      invalid: {
        blank: ''
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
        values[:valid][:address].each do |key, value|
          fill_in "order[billing_address][#{key}]", with: value
        end

        find('#order_billing_address_country').find(:xpath, 'option[2]').select_option

        values[:valid][:address].each do |key, value|
          fill_in "order[shipping_address][#{key}]", with: value
        end

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
        values[:valid][:credit_card].each do |key, value|
          fill_in "order[credit_card][#{key}]", with: value
        end

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
        values[:valid][:address].each do |key, value|
          fill_in "order[billing_address][#{key}]", with: value
        end

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
        values[:valid][:credit_card].each do |key, value|
          fill_in "order[credit_card][#{key}]", with: value
        end

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
  end

  context 'when failure' do
    before do
      create(:book)
      login_as(user, scope: :user)
    end

    it 'User redirects if order_items are empty' do
      visit checkout_step_path(:address)

      expect(page).to have_current_path(root_path)

      expect(page).to have_content(I18n.t('order_item.errors.no_items'))
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
          values[:valid][:address].each do |key, _value|
            fill_in "order[billing_address][#{key}]", with: values[:invalid][:blank]
          end

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
          values[:valid][:credit_card].each_key do |key|
            fill_in "order[credit_card][#{key}]", with: values[:invalid][:blank]
          end

          find('input[type="submit"]').click
        end

        expect(page).to have_current_path(checkout_step_path(:payment))
        expect(all('span.help-block').size).to eq(4)
      end
    end
  end
  # rubocop:enable MultipleExpectations, ExampleLength
end
