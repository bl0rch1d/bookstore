describe ReviewDecorator do
  subject(:review) { create(:review).decorate }

  it 'decorates user' do
    expect(review.user).to respond_to(:full_name)
    expect(review.user).to respond_to(:initials)
  end
end
