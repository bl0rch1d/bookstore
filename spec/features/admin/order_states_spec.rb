describe 'Order states' do
  before do
    admin_user = create(:admin_user)
    login_as(admin_user, scope: :admin_user)
  end

  context 'when admin changes order state' do
    it 'from in_progress to in_delivery' do
      create(:order, state: I18n.t('order.filter.in_progress'))
      visit admin_orders_path

      click_link(I18n.t('admin.order.actions.change_state'))

      expect(page).to have_current_path(admin_order_path(Order.last))

      click_link(I18n.t('admin.order.actions.deliver'))

      expect(page).to have_content(I18n.t('order.filter.in_delivery'))
      expect(Order.last.state).to eq(I18n.t('order.filter.in_delivery'))
    end

    it 'from in_delivery to delivered' do
      create(:order, state: I18n.t('order.filter.in_delivery'))
      visit admin_orders_path

      click_link(I18n.t('admin.order.actions.change_state'))

      expect(page).to have_current_path(admin_order_path(Order.last))

      click_link(I18n.t('admin.order.actions.confirm_delivery'))

      expect(page).to have_content(I18n.t('order.filter.delivered'))
      expect(Order.last.state).to eq(I18n.t('order.filter.delivered'))
    end

    it 'from in_progress/in_delivery to canceled' do
      create(:order, state: I18n.t('order.filter.in_progress'))
      visit admin_orders_path

      click_link(I18n.t('admin.order.actions.change_state'))

      expect(page).to have_current_path(admin_order_path(Order.last))

      click_link(I18n.t('admin.order.actions.cancel'))

      expect(page).to have_content(I18n.t('order.filter.canceled'))
      expect(Order.last.state).to eq(I18n.t('order.filter.canceled'))
    end
  end
end
