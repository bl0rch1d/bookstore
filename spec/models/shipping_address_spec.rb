RSpec.describe ShippingAddress, type: :model do
  context 'relations' do
    it { is_expected.to belong_to(:addressable) }
  end
end
