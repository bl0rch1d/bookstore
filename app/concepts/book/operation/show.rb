class Book::Show < Trailblazer::Operation
  step Model(Book, :find_by)
end