class Book::Show < Trailblazer::Operation
  step :model

  def model(ctx, params:, **)
    ctx['model'] = Book.includes(images_attachments: :blob).find(params[:id])
  end
end
