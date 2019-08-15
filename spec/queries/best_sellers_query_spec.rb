describe BestSellersQuery do
  let(:result) { described_class.new(Category.all).call }

  5.times do
    let!(:categories) { create_list(:category, 4, :with_books) }

    before do
      create_list(
        :order_item, 5,
        book: categories[rand(1..3)].books[rand(1..4)],
        order: create(:order, state: I18n.t('order.filter.delivered'))
      )
    end

    let!(:best_1) do
      create(
        :order_item,
        book: categories[0].books[3],
        quantity: 200,
        order: create(:order, state: I18n.t('order.filter.delivered'))
      )
    end

    let!(:best_2) do
      create(
        :order_item,
        book: categories[1].books[4],
        quantity: 200,
        order: create(:order, state: I18n.t('order.filter.delivered'))
      )
    end

    let!(:best_3) do
      create(
        :order_item,
        book: categories[2].books[2],
        quantity: 200,
        order: create(:order, state: I18n.t('order.filter.delivered'))
      )
    end

    let!(:best_4) do
      create(
        :order_item,
        book: categories[3].books[1],
        quantity: 200,
        order: create(:order, state: I18n.t('order.filter.delivered'))
      )
    end

    it 'returns AR with 4 bestsellers' do
      expect(result).to be_a(ActiveRecord::Relation)
      expect(result).to eq([best_1.book, best_2.book, best_3.book, best_4.book])
    end
  end
end
