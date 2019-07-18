class Review::Create < Trailblazer::Operation
  step Model(Review, :new)
  step Policy::Pundit(ReviewPolicy, :create?)
  step Contract::Build(constant: Review::Contract::Create)
  step Contract::Validate()
  step Contract::Persist()
end
