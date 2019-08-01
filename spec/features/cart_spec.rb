RSpec.describe 'Cart', type: :feature do
  let!(:books) { create_list(:book, 20) }

  before do
    visit root_path
    click_link('Buy Now')

    find_link('AddToCartLink', match: :first, visible: false).click

    click_link('Buy Now')

    visit cart_index_path
  end

  context 'when user updates order_items' do
    it 'increments' do
      find_link('increment', match: :first).click

      expect(page).to have_content(I18n.t('order_item.notice.updated'))
    end

    it 'decrements' do
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
    before do
      within('#applyCoupon') do
        fill_in 'code',	with: create(:coupon).code

        click_button('Apply Coupon')
      end
    end

    it 'user can apply coupon' do
      expect(page).to have_content(I18n.t('coupon.applied'))
    end

    it 'user can apply only one coupon' do
      expect(find("input[placeholder='Only one coupon can be applied']")).to be_truthy
    end
  end
end
