class Order::Show < Trailblazer::Operation
  step Contract::Build(constant: Order::Contract::Show)
  step Contract::Validate(), fail_fast: true
  step Model(Order, :find_by)
  step Policy::Pundit(Order::Policy::ShowPolicy, :show?)
end
