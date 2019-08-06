RSpec.describe UserDecorator, type: :decorator do
  subject(:user) { create(:user, :with_addresses).decorate }

  it { expect(user.billing_address).to respond_to(:city_zip) }
  it { expect(user.shipping_address).to respond_to(:full_name) }
end
