FROM nginx:1.16

# Install dependencies
RUN apt-get update -qq && \
    apt-get install -y apache2-utils curl && \    
    rm -rf /var/lib/apt/lists/*
 
# establish where Nginx should look for files
ENV RAILS_ROOT /var/www/bookstore

# Set our working directory inside the image
WORKDIR $RAILS_ROOT
 
# create log directory
RUN mkdir log
 
# Copy Nginx config template
COPY config/nginx.conf /tmp/docker_example.nginx

# substitute variable references in the Nginx config template for real values from the environment
# put the final config in its place
RUN envsubst '$RAILS_ROOT' < /tmp/docker_example.nginx > /etc/nginx/conf.d/default.conf
RUN rm -rf /etc/nginx/sites-available/default
COPY config/nginx.conf /etc/nginx/sites-enabled/nginx.conf

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout log/nginx.access.log
RUN ln -sf /dev/stderr log/nginx.error.log

EXPOSE 80

RUN chown -R www-data:www-data /var/www

# Use the "exec" form of CMD so Nginx shuts down gracefully on SIGTERM (i.e. `docker stop`)
CMD [ "nginx", "-g", "daemon off;" ]
