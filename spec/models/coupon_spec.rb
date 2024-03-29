describe Coupon, type: :model do
  context 'relations' do
    it { is_expected.to belong_to(:order).optional }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:code) }
    it { is_expected.to validate_presence_of(:discount) }

    it { is_expected.to validate_numericality_of(:discount).is_greater_than_or_equal_to(Coupon::MIN_DISCOUNT) }
    it { is_expected.to validate_numericality_of(:discount).is_less_than_or_equal_to(Coupon::MAX_DISCOUNT) }
  end
end
