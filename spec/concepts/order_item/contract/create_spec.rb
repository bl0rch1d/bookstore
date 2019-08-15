describe OrderItem::Contract::Create do
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

      let(:errors) { { quantity: [I18n.t('errors.messages.not_a_number')] } }

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

      let(:errors) do
        { quantity: [I18n.t('errors.messages.greater_than_or_equal_to', count: described_class::MIN_QUANTITY)] }
      end

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

      let(:errors) do
        { quantity: [I18n.t('errors.messages.less_than_or_equal_to', count: described_class::MAX_QUANTITY)] }
      end

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

      let(:errors) { { price: [I18n.t('errors.messages.greater_than_or_equal_to', count: described_class::MIN_PRICE)] } }

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

      let(:errors) { { price: [I18n.t('errors.messages.less_than_or_equal_to', count: described_class::MAX_PRICE)] } }

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

      let(:errors) do
        { subtotal: [I18n.t('errors.messages.greater_than_or_equal_to', count: described_class::MIN_PRICE)] }
      end

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

      let(:errors) { { subtotal: [I18n.t('errors.messages.less_than_or_equal_to', count: described_class::MAX_PRICE)] } }

      it do
        expect(contract.validate(params)).to be_falsey
        expect(contract.errors.messages).to eq(errors)
      end
    end
  end
end
