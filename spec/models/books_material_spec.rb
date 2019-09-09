describe BooksMaterial, type: :model do
  context 'relations' do
    it { is_expected.to belong_to(:book) }
    it { is_expected.to belong_to(:material) }
  end
end
