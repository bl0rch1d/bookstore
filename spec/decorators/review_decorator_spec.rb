require 'rails_helper'

RSpec.describe ReviewDecorator do
  subject(:review) { create(:review).decorate }

  it '#customer_initials' do
    expect(review.customer_initials).to eq(review.customer_full_name.split(' ').map(&:first).join.to_s)
  end

  it '#customer_full_name' do
    full_name = "#{review.customer.billing_address.first_name} #{review.customer.billing_address.last_name}"

    expect(review.customer_full_name).to eq(full_name)
  end
end
