threads_count = Integer(ENV['RAILS_MAX_THREADS'] || 5)
threads threads_count, threads_count

preload_app!

port        ENV['PORT']     || 3000
environment ENV['RACK_ENV'] || 'development'

# Allow puma to be restarted by `rails restart` command.
plugin :tmp_restart

# workers Integer(ENV['WEB_CONCURRENCY'] || 2)
# on_worker_boot do
#   ActiveRecord::Base.establish_connection
# end
