class BooksSortingQuery
  def initialize(params)
    @params = params
  end

  def call
    sort
  end

  def sort
    case @params[:sort_by]
    when 'newest'           then newest(from_category)
    when 'popular'          then popular(from_category)
    when 'low_price'        then low_price(from_category)
    when 'high_price'       then high_price(from_category)
    when 'title_ascending'  then title_ascending(from_category)
    when 'title_descending' then title_descending(from_category)
    else title_ascending(from_category)
    end
  end

  def from_category
    Category.all.where(id: @params[:category_id])[0]&.books || Book.all
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
