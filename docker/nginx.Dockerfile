FROM nginx

RUN apt-get update -qq; apt-get install apache2-utils curl; rm -rf /var/lib/apt/lists/*

ENV RAILS_ROOT /var/www/bookstore

RUN mkdir log

COPY config/nginx.conf /tmp/docker_example.nginx


