#!/bin/bash

set -e

rm -f /var/www/bookstore/tmp/pids/server.pid

bundle check || bundle install

bundle exec rake db:create db:migrate db:seed

exec "$@"
