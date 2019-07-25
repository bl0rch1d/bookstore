require 'simplecov'

SimpleCov.start 'rails' do
  add_filter 'spec'
  add_filter 'app/admin'
  add_filter 'app/channels'
  add_filter 'app/mailer'
  add_filter 'app/jobs'
  minimum_coverage 90
end
