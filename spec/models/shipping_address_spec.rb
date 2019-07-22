RSpec.describe ShippingAddress, type: :model do
  it { is_expected.to belong_to(:addressable) }
end
