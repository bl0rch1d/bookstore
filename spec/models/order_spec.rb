require 'rails_helper'

RSpec.describe Order, type: :model do
  subject(:order) { create :order }

  it { is_expected.to have_many(:order_items).dependent(:destroy) }
  it { is_expected.to have_many(:books).through(:order_items) }

  it { is_expected.to have_one(:shipping_address).dependent(:destroy) }
  it { is_expected.to have_one(:billing_address).dependent(:destroy) }

  it { is_expected.to have_one(:credit_card).dependent(:destroy) }
  it { is_expected.to have_one(:coupon).dependent(:destroy) }

  it { is_expected.to belong_to(:shipping_method).optional }
  it { is_expected.to belong_to(:customer).optional }

  context 'when aasm state' do
    it 'in_progress -> in_delivery' do
      expect(order).to transition_from(:in_progress).to(:in_delivery).on_event(:deliver)
    end

    it 'in_delivery -> delivered' do
      expect(order).to transition_from(:in_delivery).to(:delivered).on_event(:confirm_delivery)
    end

    it 'any -> canceled' do
      expect(order).to transition_from(:in_progress).to(:canceled).on_event(:cancel)
      expect(order).to transition_from(:in_delivery).to(:canceled).on_event(:cancel)
    end
  end
end
