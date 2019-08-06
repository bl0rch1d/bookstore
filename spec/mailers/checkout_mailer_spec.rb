RSpec.describe CheckoutMailer, type: :mailer do
  let!(:order) { create :order, :full }

  describe 'complete  ' do
    let(:mail) { described_class.complete(order.user, order) }

    it 'renders the headers' do
      expect(mail.subject).to eq(I18n.t('order.mailer.subject', order_number: order.number))
      expect(mail.to).to eq([order.user.email])
      expect(mail.from).to eq([I18n.t('store.email')])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match("Hello, #{order.billing_address.decorate.full_name}")
    end
  end
end
