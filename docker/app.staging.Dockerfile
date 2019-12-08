ARG RUBY_VERSION

FROM ruby:$RUBY_VERSION-buster

ARG PG_MAJOR
ARG NODE_MAJOR
ARG BUNDLER_VERSION
ARG YARN_VERSION

RUN curl -sSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - \
  && echo 'deb http://apt.postgresql.org/pub/repos/apt/ buster-pgdg main' $PG_MAJOR > /etc/apt/sources.list.d/pgdg.list

RUN curl -sL https://deb.nodesource.com/setup_$NODE_MAJOR.x | bash -

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo 'deb http://dl.yarnpkg.com/debian/ stable main' > /etc/apt/sources.list.d/yarn.list

RUN apt-get update -qq; apt-get upgrade -yq

RUN apt-get install -yq --no-install-recommends \
                         build-essential \
                         postgresql-client-$PG_MAJOR \
                         imagemagick \
                         nodejs \
                         yarn=$YARN_VERSION \
                         awscli \
                         cron \
                         vim \
                         nano

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    truncate -s 0 /var/log/*log

ENV APP_USER www-data
ENV RAILS_ROOT /var/www/bookstore
ENV LANG=C.UTF-8 \
    BUNDLE_PATH=$RAILS_ROOT/vendor/bundle \
    BUNDLE_JOBS=20 \
    BUNDLE_RETRY=5

# That allows us to run rails, rake, rspec andother
# binstubbed commands without prefixing them with bundle exec.
ENV BUNDLE_PATH $GEM_HOME
ENV BUNDLE_APP_CONFIG=$BUNDLE_PATH \
  BUNDLE_BIN=$BUNDLE_PATH/bin
ENV PATH /app/bin:$BUNDLE_BIN:$PATH

RUN gem update --system; gem install bundler:$BUNDLER_VERSION

RUN mkdir -p $RAILS_ROOT/tmp/pids

WORKDIR $RAILS_ROOT

COPY Gemfile* ./

RUN bundle install --without development --jobs $BUNDLE_JOBS --retry $BUNDLE_RETRY --path $BUNDLE_PATH

COPY . .

RUN RAILS_ENV=staging bin/rake assets:precompile

RUN chown -R $APP_USER:$APP_USER /var/www

USER $APP_USER
