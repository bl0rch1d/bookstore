class Book::Show < Trailblazer::Operation
  step :model

  def model(ctx, params:, **)
    ctx['model'] = Book.includes(images_attachments: :blob).find_by(id: params[:id])
  end
end
