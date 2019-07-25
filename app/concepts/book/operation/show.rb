class Book::Show < Trailblazer::Operation
  step Contract::Build(constant: Book::Contract::Show)
  step Contract::Validate()
  step Model(Book, :find_by)
end
