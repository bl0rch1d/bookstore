class Book::Index < Trailblazer::Operation
  step Contract::Build(constant: Book::Contract::Index)
  step Contract::Validate(), fail_fast: true

  step :model
  step :overflow?
  failure :overflow

  def model(ctx, params:, **)
    ctx['pagy'], ctx['model'] = ::Service::Pagy.call(
      Book::Query::Index.new.call(params),
      page: params[:page],
      items: Book::PAGINATION_INDEX
    )
  end

  def overflow?(_ctx, pagy:, **)
    !pagy.overflow?
  end

  def overflow(ctx, **)
    ctx['contract.default'].errors.add(:page, 'is out of limits')
  end
end
