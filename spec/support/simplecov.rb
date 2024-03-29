require 'simplecov'

SimpleCov.start 'rails' do
  add_filter 'spec'
  add_filter 'app/admin'
  add_filter 'app/channels'
  add_filter 'app/jobs'

  groups = %w[concepts controllers decorators helpers mailers models queries validators]
  groups.each { |name| add_group name.capitalize, "/app/#{name}" }

  minimum_coverage 95
end
