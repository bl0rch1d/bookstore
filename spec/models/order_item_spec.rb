describe OrderItem, type: :model do
  context 'relations' do
    it { is_expected.to belong_to(:order).optional }
    it { is_expected.to belong_to(:book) }
  end
end
