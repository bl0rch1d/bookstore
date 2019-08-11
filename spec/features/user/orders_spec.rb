describe 'Orders page' do
  let(:user) { create(:user) }

  before do
    I18n.t('order.filter').values.each do |state|
      create(:order, :at_complete_step, user: user, state: state)
    end
  end

  context 'when authorized' do
    before do
      login_as(user, scope: :user)
      visit user_orders_path(user)
    end

    it 'user can see orders with default in_progress filter' do
      expect(page).to have_current_path("/users/#{user.id}/orders")

      orders_on_page = all('a', class: 'general-order-number')

      expect(orders_on_page.size).to eq(user.orders.where(state: I18n.t('order.filter.in_progress')).size)
    end

    context 'when user uses filter' do
      it 'see orders with all states' do
        find('a', class: 'lead').click
        find('a', text: 'all').click

        sleep 0.5

        orders_on_page = all('a', class: 'general-order-number')

        expect(orders_on_page.size).to eq(user.orders.completed.size)
      end

      it 'see order with in_delivery state' do
        find('a', class: 'lead').click
        find('a', text: 'In delivery').click

        orders_on_page = all('a', class: 'general-order-number')

        expect(orders_on_page.size).to eq(user.orders.where(state: I18n.t('order.filter.in_delivery')).size)
      end

      it 'see order with delivered state' do
        find('a', class: 'lead').click
        find('a', text: 'Delivered').click

        orders_on_page = all('a', class: 'general-order-number')

        expect(orders_on_page.size).to eq(user.orders.where(state: I18n.t('order.filter.delivered')).size)
      end

      it 'see order with canceled state' do
        find('a', class: 'lead').click
        find('a', text: 'Canceled').click

        orders_on_page = all('a', class: 'general-order-number')

        expect(orders_on_page.size).to eq(user.orders.where(state: I18n.t('order.filter.canceled')).size)
      end
    end

    context 'when order page' do
      before do
        all('a', class: 'general-order-number').first.click
        sleep 0.5
      end

      it 'user can visit order page' do
        expect(page).to have_current_path("/users/#{user.id}/orders/#{user.orders.completed.first.id}")
      end

      # rubocop:disable RSpec/ExampleLength, RSpec/MultipleExpectations
      it 'user can view detailed info about order' do
        extend ActionView::Helpers::NumberHelper

        order = user.orders.completed.first.decorate

        expect(page).to have_current_path("/users/#{user.id}/orders/#{order.id}")

        expect(page).to have_content(I18n.t('address.billing'))
        expect(page).to have_content(I18n.t('address.shipping'))
        expect(page).to have_content(I18n.t('checkout.shipping.title'))
        expect(page).to have_content(I18n.t('checkout.payment.info'))

        expect(page).to have_content(order.billing_address.full_name)
        expect(page).to have_content(order.billing_address.city_zip)
        expect(page).to have_content(order.billing_address.phone)
        expect(page).to have_content(order.billing_address.country)
        expect(page).to have_content(order.billing_address.address_line)

        expect(page).to have_content(order.shipping_address.full_name)
        expect(page).to have_content(order.shipping_address.city_zip)
        expect(page).to have_content(order.shipping_address.phone)
        expect(page).to have_content(order.shipping_address.country)
        expect(page).to have_content(order.shipping_address.address_line)

        expect(page).to have_content(order.shipping_method.title)
        expect(page).to have_content(order.shipping_method.price)

        expect(page).to have_content(order.credit_card.secure_number)
        expect(page).to have_content(order.credit_card.expiration_date)

        order.order_items.each do |order_item|
          expect(page).to have_content(order_item.book.title)
        end

        expect(page).to have_content(number_to_currency(order.subtotal, unit: I18n.t('currency.euro')))
        expect(page).to have_content(number_to_currency(order.shipping_method.price, unit: I18n.t('currency.euro')))
        expect(page).to have_content(number_to_currency(order.total, unit: I18n.t('currency.euro')))
      end
      # rubocop:enable RSpec/ExampleLength, RSpec/MultipleExpectations
    end

    context 'when user tries to view orders that do not belong to him' do
      it 'redirects user to root with flash message' do
        visit user_orders_path(3)

        expect(page).to have_content(I18n.t('auth.errors.not_authorized'))
      end
    end

    context 'when user tries to view order that do not belong to him' do
      it 'redirects user to root with flash message' do
        visit user_order_path(3, 32)

        expect(page).to have_content(I18n.t('auth.errors.not_authorized'))
      end
    end
  end

  context 'when user not authirzed' do
    context 'when orders page' do
      it 'redirects user to root with flash message' do
        visit user_orders_path(user)

        expect(page).to have_content(I18n.t('auth.errors.not_authorized'))
      end
    end

    context 'when order page' do
      it 'redirects user to root with flash message' do
        visit user_order_path(user, user.orders.completed.sample.id)

        expect(page).to have_content(I18n.t('auth.errors.not_authorized'))
      end
    end
  end
end
