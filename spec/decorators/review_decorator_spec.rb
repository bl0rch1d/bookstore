RSpec.describe ReviewDecorator do
  subject(:review) { create(:review).decorate }

  it '#user_initials' do
    expect(review.user_initials).to eq(review.user_full_name.split(' ').map(&:first).join.to_s)
  end

  it '#user_full_name' do
    full_name = "#{review.user.billing_address.first_name} #{review.user.billing_address.last_name}"

    expect(review.user_full_name).to eq(full_name)
  end
end
