describe Checkout::Policy::UserGuard do
  let(:result) { described_class.new.call(nil, params: params) }

  let(:user) { create(:user) }

  describe 'Success' do
    %i[address shipping payment confirm complete].each do |step|
      let(:params) { { current_user: user } }

      it "authorize user at #{step} step" do
        result = described_class.new.call(nil, params: params.merge(
          current_order: create(:order, :"at_#{step}_step", user: user),
          step: step
        ))

        expect(result).to be_truthy
      end
    end
  end

  describe 'Failure' do
    %i[address shipping payment confirm complete].each do |step|
      let(:params) { { current_user: create(:user) } }

      it "not authorize user at #{step} step" do
        result = described_class.new.call(nil, params: params.merge(
          current_order: create(:order, :"at_#{step}_step", user: user),
          step: step
        ))

        expect(result).to be_falsey
      end
    end
  end
end
