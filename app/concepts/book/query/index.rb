module Book::Query
  class Index
    SORTINGS = %w[newest popular high_price low_price title_ascending title_descending].freeze

    # rubocop: disable Metrics/AbcSize, CyclomaticComplexity
    def call(params)
      @params = params

      case @params[:sort_by]
      when I18n.t('sortings.system.newest')           then newest(from_category)
      when I18n.t('sortings.system.popular')          then popular(from_category)
      when I18n.t('sortings.system.low_price')        then low_price(from_category)
      when I18n.t('sortings.system.high_price')       then high_price(from_category)
      when I18n.t('sortings.system.title_ascending')  then title_ascending(from_category)
      when I18n.t('sortings.system.title_descending') then title_descending(from_category)
      else title_ascending(from_category)
      end
    end
    # rubocop: enable Metrics/AbcSize, CyclomaticComplexity

    private

    def from_category
      category_books = (@params[:category_id] ? Category.find(@params[:category_id]).books : Book.all)

      category_books.includes(:images_attachments, :authors)
    end

    def newest(books)
      books.most_recent
    end

    def popular(books)
      books.most_popular
    end

    def low_price(books)
      books.ascending_price
    end

    def high_price(books)
      books.descending_price
    end

    def title_ascending(books)
      books.ascending_title
    end

    def title_descending(books)
      books.descending_title
    end
  end
end
