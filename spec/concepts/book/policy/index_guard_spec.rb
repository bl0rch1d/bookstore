RSpec.describe Book::Policy::IndexGuard do
  let(:result) { described_class.new.call(nil, params: params) }

  describe 'Success' do
    before do
      create :category
    end

    let(:params) { { category_id: 1 } }

    it { expect(result).to be_truthy }
  end

  describe 'Failure' do
    context 'when category id is invalid' do
      before do
        create :category
      end

      ['dads', 100, -12].each do |id|
        let(:params) { { category_id: id } }

        it { expect(result).to be_falsey }
      end
    end
  end
end
