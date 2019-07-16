class Book::Index < Trailblazer::Operation
  step Contract::Build(constant: Book::Contract::Index)
  step Contract::Validate(), fail_fast: true

  step :model

  def model(ctx, params:, **)
    ctx['pagy'], ctx['model'] = ::Service::Pagy.call(Book::Query::Index.call(params), page: params[:page], items: 12)
  end
end
