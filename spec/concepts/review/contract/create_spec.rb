RSpec.describe Review::Contract::Create do
  let(:contract) { described_class.new(Review.new) }

  describe 'Success' do
    let(:review_params) { attributes_for(:review) }

    it { expect(contract.validate(review_params)).to be_truthy }
  end

  describe 'Failure' do
    let(:review_params) { attributes_for(:user) }

    context 'when review params invalid' do
      let(:errors) do
        {
          user_id: ["can't be blank", 'is not a number'],
          book_id: ["can't be blank", 'is not a number'],
          title: ["can't be blank"],
          body: ["can't be blank", 'is invalid'],
          rating: ["can't be blank", 'is invalid', 'is not a number', 'is not included in the list']
        }
      end

      it 'fails' do
        expect(contract.validate(review_params)).to be_falsey
        expect(contract.errors.messages).to match errors
      end
    end
  end
end
