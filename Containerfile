# its the only version that has php 7
FROM alpine:3.15

# install packages
RUN apk update && apk add --no-cache \
    nginx \
    php7 \
    php7-fpm \
    php7-mysqli \
    php7-pdo \
    php7-pdo_mysql \
    php7-opcache \
    php7-session \
    php7-json \
    php7-mbstring \
    php7-xml \
    php7-curl \
    mariadb \
    mariadb-client \
    supervisor

# create required directories
RUN mkdir -p /run/nginx \
    /var/log/supervisor \
    /var/www/html

# basic nginx config
RUN rm /etc/nginx/http.d/default.conf
COPY container/nginx.conf /etc/nginx/http.d/default.conf

# php-fpm config
RUN sed -i 's|;daemonize = yes|daemonize = no|' /etc/php7/php-fpm.conf && \
    sed -i 's|listen = 127.0.0.1:9000|listen = 9000|' /etc/php7/php-fpm.d/www.conf

# mariadb setup
RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld 
COPY container/mysql.sh /mysql.sh

# supervisor config
COPY container/supervisord.conf /etc/supervisord.conf

# setup internal tools
COPY container/tools /opt/tools

# expose ports
EXPOSE 80 3306

VOLUME ["/var/lib/mysql", "/var/www/html"]

# start services
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]

