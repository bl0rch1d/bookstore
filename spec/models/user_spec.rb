describe User, type: :model do
  context 'relations' do
    it { is_expected.to have_many(:reviews).dependent(:destroy) }
    it { is_expected.to have_many(:orders).dependent(:destroy) }

    it { is_expected.to have_one(:billing_address).dependent(:destroy) }
    it { is_expected.to have_one(:shipping_address).dependent(:destroy) }
  end

  context 'validations' do
    it { is_expected.to accept_nested_attributes_for(:billing_address) }
    it { is_expected.to accept_nested_attributes_for(:shipping_address) }
  end
end
