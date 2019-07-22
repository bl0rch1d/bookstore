RSpec.describe CategoryDecorator do
  subject(:category) { create(:category).decorate }

  it '#system_format' do
    expect(category.system_format).to eq(category.title.downcase.tr(' ', '_'))
  end
end
