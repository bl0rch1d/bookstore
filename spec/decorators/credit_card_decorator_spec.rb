describe CreditCardDecorator do
  subject(:credit_card) { create(:credit_card).decorate }

  it '#secure_number' do
    expect(credit_card.secure_number).to eq("#{Array.new(3) { '**' }.join(' ')} #{credit_card.number&.last(4)}")
  end
end
