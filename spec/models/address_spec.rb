RSpec.describe Address, type: :model do
  context 'relations' do
    it { is_expected.to belong_to(:addressable) }
  end

  context 'enum' do
    it { is_expected.to define_enum_for(:type).with_values(%i[BillingAddress ShippingAddress]) }
  end
end
