RSpec.describe ReviewDecorator do
  subject(:review) { create(:review).decorate }

  it '#user_initials' do
    expect(review.user_initials).to eq(review.user_full_name.split(' ').map(&:first).join.to_s)
  end

  context 'when user_full_name' do
    it 'if user has billing address' do
      full_name = "#{review.user.billing_address.first_name} #{review.user.billing_address.last_name}"

      expect(review.user_full_name).to eq(full_name)
    end

    it 'if user has billing address through orders' do
      review.user = create(:user)
      create(:order, :full, user: review.user)

      first_name = review.user.orders&.first&.billing_address&.first_name
      last_name  = review.user.orders&.first&.billing_address&.last_name

      expect(review.user_full_name).to eq("#{first_name} #{last_name}")
    end

    it 'if user has email' do
      review.user = create(:user)
      create(:order, user: review.user)

      full_name = review.user.email

      expect(review.user_full_name).to eq(full_name)
    end
  end
end
