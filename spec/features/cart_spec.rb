describe 'Cart', type: :feature do
  before do
    create :book

    visit root_path
    click_link(I18n.t('store.button.buy_now'))

    find_link('AddToCartLink', match: :first, visible: false).click

    click_link(I18n.t('store.button.buy_now'))

    visit order_order_items_path(Order.last)
  end

  context 'when user updates order_items' do
    it 'user can increment quantity' do
      find_link('increment', match: :first).click

      expect(page).to have_content(I18n.t('order_item.notice.updated'))
    end

    it 'user can decrement quantity' do
      find_link('increment', match: :first).click
      find_link('decrement', match: :first).click

      expect(page).to have_content(I18n.t('order_item.notice.updated'))
    end
  end

  it 'user can delete order items' do
    find('.close', match: :first).click

    expect(page).to have_content(I18n.t('order_item.notice.removed'))
  end

  context 'when user appling a coupon' do
    let(:coupon) { create(:coupon) }
    let(:used_coupon) { create(:coupon, used: true) }

    it 'user can apply coupon' do
      within('#applyCoupon') do
        fill_in 'code', with: coupon.code

        click_button(I18n.t('coupon.apply'))
      end

      expect(page).to have_content(I18n.t('coupon.applied'))
    end

    context 'when error' do
      it 'user can apply only one coupon' do
        within('#applyCoupon') do
          fill_in 'code', with: coupon.code

          click_button(I18n.t('coupon.apply'))
        end

        expect(find("input[placeholder='#{I18n.t('form.placeholders.only_one_coupon')}']")).to be_truthy
      end

      it 'user can apply one coupon only for one order' do
        within('#applyCoupon') do
          fill_in 'code', with: used_coupon.code

          click_button(I18n.t('coupon.apply'))
        end

        expect(page).to have_content(I18n.t('coupon.errors.used'))
      end
    end
  end
end
