RSpec.describe CreditCard, type: :model do
  context 'relations' do
    it { is_expected.to belong_to(:order) }
  end
end
