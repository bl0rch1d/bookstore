describe Address::Policy::EditGuard do
  let(:result) { described_class.new.call(nil, params: params) }

  context 'when user authenticated' do
    let(:params) { { current_user: create(:user) } }

    it { expect(result).to be_truthy }
  end

  context 'when user not authenticated' do
    let(:params) { { current_user: nil } }

    it { expect(result).to be_falsey }
  end
end
