class Address::Create < Trailblazer::Operation
  class Present < Trailblazer::Operation
    step Model(Address, :new)
    step Contract::Build(constant: Address::Contract::Create)
  end

  step Nested(Present)
  step Contract::Validate()
  step Contract::Persist()
end