RSpec.describe OrderItem::Contract::Create do
  let(:contract) { described_class.new(OrderItem.new) }

  describe 'Success' do
    let(:params) do
      {
        quantity: 1.0,
        subtotal: 1.0,
        price: 1.0,
        book_id: create(:book).id,
        order_id: create(:order).id
      }
    end

    it { expect(contract.validate(params)).to be_truthy }
  end

  describe 'Failure' do
    context 'when book_id is not present' do
      let(:params) do
        {
          quantity: 1.0,
          subtotal: 1.0,
          price: 1.0,
          order_id: create(:order).id
        }
      end

      let(:errors) { { book_id: ["can't be blank", 'is not a number'] } }

      it do
        expect(contract.validate(params)).to be_falsey
        expect(contract.errors.messages).to eq(errors)
      end
    end

    context 'when book_id is not a number' do
      let(:params) do
        {
          quantity: 1.0,
          subtotal: 1.0,
          price: 1.0,
          book_id: 'dsdds',
          order_id: create(:order).id
        }
      end

      let(:errors) { { book_id: ['is not a number'] } }

      it do
        expect(contract.validate(params)).to be_falsey
        expect(contract.errors.messages).to eq(errors)
      end
    end

    context 'when book_id is negative' do
      let(:params) do
        {
          quantity: 1.0,
          subtotal: 1.0,
          price: 1.0,
          book_id: -10,
          order_id: create(:order).id
        }
      end

      let(:errors) { { book_id: ['must be greater than or equal to 1'] } }

      it do
        expect(contract.validate(params)).to be_falsey
        expect(contract.errors.messages).to eq(errors)
      end
    end

    context 'when quantity is not a number' do
      let(:params) do
        {
          quantity: 'ddd',
          subtotal: 1.0,
          price: 1.0,
          book_id: 1,
          order_id: create(:order).id
        }
      end

      let(:errors) { { quantity: ['is not a number'] } }

      it do
        expect(contract.validate(params)).to be_falsey
        expect(contract.errors.messages).to eq(errors)
      end
    end

    context 'when quantity is too small' do
      let(:params) do
        {
          quantity: 0,
          subtotal: 1.0,
          price: 1.0,
          book_id: 1,
          order_id: create(:order).id
        }
      end

      let(:errors) { { quantity: ['must be greater than or equal to 1'] } }

      it do
        expect(contract.validate(params)).to be_falsey
        expect(contract.errors.messages).to eq(errors)
      end
    end

    context 'when quantity is too big' do
      let(:params) do
        {
          quantity: 101,
          subtotal: 1.0,
          price: 1.0,
          book_id: 1,
          order_id: create(:order).id
        }
      end

      let(:errors) { { quantity: ['must be less than or equal to 100'] } }

      it do
        expect(contract.validate(params)).to be_falsey
        expect(contract.errors.messages).to eq(errors)
      end
    end

    context 'when price is too small' do
      let(:params) do
        {
          quantity: 1,
          subtotal: 1.0,
          price: -1,
          book_id: 1,
          order_id: create(:order).id
        }
      end

      let(:errors) { { price: ['must be greater than or equal to 0'] } }

      it do
        expect(contract.validate(params)).to be_falsey
        expect(contract.errors.messages).to eq(errors)
      end
    end

    context 'when price is too big' do
      let(:params) do
        {
          quantity: 1,
          subtotal: 1.0,
          price: 100_000_000_000,
          book_id: 1,
          order_id: create(:order).id
        }
      end

      let(:errors) { { price: ['must be less than or equal to 100000'] } }

      it do
        expect(contract.validate(params)).to be_falsey
        expect(contract.errors.messages).to eq(errors)
      end
    end

    context 'when subtotal is too small' do
      let(:params) do
        {
          quantity: 1,
          subtotal: -1,
          price: 1.0,
          book_id: 1,
          order_id: create(:order).id
        }
      end

      let(:errors) { { subtotal: ['must be greater than or equal to 0'] } }

      it do
        expect(contract.validate(params)).to be_falsey
        expect(contract.errors.messages).to eq(errors)
      end
    end

    context 'when subtotal is too big' do
      let(:params) do
        {
          quantity: 1,
          subtotal: 100_000_000,
          price: 1.0,
          book_id: 1,
          order_id: create(:order).id
        }
      end

      let(:errors) { { subtotal: ['must be less than or equal to 100000'] } }

      it do
        expect(contract.validate(params)).to be_falsey
        expect(contract.errors.messages).to eq(errors)
      end
    end
  end
end
