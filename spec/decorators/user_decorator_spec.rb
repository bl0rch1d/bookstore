describe UserDecorator, type: :decorator do
  subject(:user) { create(:user, :with_addresses).decorate }

  it { expect(user.billing_address).to respond_to(:city_zip) }
  it { expect(user.shipping_address).to respond_to(:full_name) }

  it '#initial' do
    expect(user.initials).to eq(user.full_name.split(' ').map(&:first).join.to_s)
  end

  context 'when full_name' do
    it 'if user has billing address' do
      full_name = "#{user.billing_address.first_name} #{user.billing_address.last_name}"

      expect(user.full_name).to eq(full_name)
    end

    context 'when user has billing address through orders' do
      let(:user) { create(:user, orders: [create(:order, :at_complete_step)]).decorate }

      it do
        first_name = user.orders.first.billing_address.first_name
        last_name  = user.orders.first.billing_address.last_name

        expect(user.full_name).to eq("#{first_name} #{last_name}")
      end
    end

    context 'when user has only email' do
      let(:user) { create(:user, orders: [create(:order)]).decorate }

      it { expect(user.full_name).to eq(user.email) }
    end
  end
end
