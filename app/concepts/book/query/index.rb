module Book::Query
  class Index
    SORTINGS = %w[newest popular high_price low_price title_ascending title_descending].freeze

    def initialize(params)
      @params = params

      @books = (@params[:category_id] ? Category.find(@params[:category_id]).books : Book.all)
               .includes(:authors, images_attachments: :blob)
    end

    # rubocop: disable Metrics/AbcSize, CyclomaticComplexity
    def call
      case @params[:sort_by]
      when I18n.t('sortings.system.newest')           then newest(@books)
      when I18n.t('sortings.system.popular')          then popular(@books)
      when I18n.t('sortings.system.low_price')        then low_price(@books)
      when I18n.t('sortings.system.high_price')       then high_price(@books)
      when I18n.t('sortings.system.title_ascending')  then title_ascending(@books)
      when I18n.t('sortings.system.title_descending') then title_descending(@books)
      else title_ascending(@books)
      end
    end
    # rubocop: enable Metrics/AbcSize, CyclomaticComplexity

    private

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
