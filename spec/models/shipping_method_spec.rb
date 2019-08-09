describe ShippingMethod, type: :model do
  context 'relations' do
    it { is_expected.to have_many(:orders).dependent(:destroy) }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:min_days) }
    it { is_expected.to validate_presence_of(:max_days) }
    it { is_expected.to validate_presence_of(:price) }

    it { is_expected.to validate_uniqueness_of(:title) }
    it { is_expected.to validate_numericality_of(:price).is_greater_than_or_equal_to(ApplicationRecord::MIN_PRICE) }
    it { is_expected.to validate_numericality_of(:price).is_less_than_or_equal_to(ApplicationRecord::MAX_PRICE) }
  end
end
