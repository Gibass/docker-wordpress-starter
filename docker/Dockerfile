#syntax=docker/dockerfile:1.4
ARG PHP_VERSION=8.2

FROM composer/composer:latest-bin AS composer
FROM php:${PHP_VERSION}-fpm-alpine AS php

ENV APP_DIR=/var/www/html

# =========== Install dependencies ===========
RUN apk update && apk upgrade && \
    apk add --no-cache acl fcgi file gettext git shadow nginx supervisor

RUN curl -sSLf \
        -o /usr/local/bin/install-php-extensions \
        https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions && \
    chmod +x /usr/local/bin/install-php-extensions && \
    install-php-extensions apcu intl opcache zip xdebug mysqli pdo_mysql

### PHP Conf
COPY php/conf.d/app.ini $PHP_INI_DIR/conf.d/
COPY php/conf.d/app.dev.ini $PHP_INI_DIR/conf.d/

## Nginx conf
COPY nginx/conf/certs /etc/nginx/certs

# supervisor
COPY supervisord/conf/supervisord.conf /etc/supervisord.conf

# Add Scripts
COPY scripts/start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 443 80

WORKDIR "${APP_DIR}"
CMD ["/start.sh"]

# =========== Composer ===========
COPY --from=composer /composer /usr/bin/composer
