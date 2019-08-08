class Order::Show < Trailblazer::Operation
  step Model(Order, :find_by)
  step Policy::Pundit(Order::Policy::ShowPolicy, :show?)
end
