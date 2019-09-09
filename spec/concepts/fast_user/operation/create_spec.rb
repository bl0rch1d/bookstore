describe FastUser::Create do
  let(:result) { described_class.call(user_params) }

  describe 'Success' do
    let(:user_params) { ActionController::Parameters.new(attributes_for(:user)) }

    it 'Creates a User' do
      expect(result['model']).to be_a(User)
      expect(result['result.contract.default']).to be_success
      expect(User.last.email).to eq(user_params[:email])

      expect(result).to be_success
    end
  end

  describe 'Failure' do
    let(:user_params) { ActionController::Parameters.new(attributes_for(:book)) }

    context 'when params invalid' do
      it { expect(result).to be_failure }
    end
  end
end
