FROM ruby:2.6.5-alpine3.10

RUN apk add --no-cache \
    build-base=~0.5 \
    libxml2-dev=~2.9.9 \
    libxslt-dev=~1.1.33 \
    tzdata=~2019 \
    imagemagick=~7.0.8.58 \
    postgresql-dev=~11.6 \
    postgresql-client=~11.6 \
    curl \
    git \
    less \
    nano \
    vim \
    imagemagick \
    nodejs \
    yarn

RUN mkdir bookstore

COPY Gemfile Gemfile.lock bookstore/

WORKDIR bookstore/

RUN gem install bundler

RUN bundle install

COPY . .
