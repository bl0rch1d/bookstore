describe MostPopularQuery do
  let(:result) { described_class.new(Book.all).call }

  5.times do
    let!(:books) { create_list(:book, 10) }

    let!(:most_popular_1) do
      create_list(
        :order_item,
        5,
        book: books[4],
        quantity: 1,
        order: create(:order, state: I18n.t('order.filter.delivered'))
      )
    end

    let!(:most_popular_2) do
      create_list(
        :order_item,
        3,
        book: books[7],
        quantity: 1,
        order: create(:order, state: I18n.t('order.filter.delivered'))
      )
    end

    let!(:most_popular_3) do
      create_list(
        :order_item,
        1,
        book: books[-1],
        quantity: 1,
        order: create(:order, state: I18n.t('order.filter.delivered'))
      )
    end

    it 'returns AR with 4 bestsellers' do
      expect(result).to be_a(ActiveRecord::Relation)
      expect(result.first(3)).to eq([most_popular_1.first.book, most_popular_2.first.book, most_popular_3.first.book])
    end
  end
end
