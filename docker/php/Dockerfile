FROM composer:latest as backend-builder
WORKDIR /var/www/app
RUN apk add --no-cache freetype libpng libjpeg-turbo freetype-dev libpng-dev libjpeg-turbo-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd
COPY ./config ./config
COPY ./docroot ./docroot
COPY ./composer.* .
RUN composer install --optimize-autoloader --ignore-platform-reqs --no-interaction
RUN git clone https://github.com/drush-ops/drush.git /var/www/app/drush \
    && cd /var/www/app/drush \
    && composer install --optimize-autoloader --ignore-platform-reqs --no-interaction

FROM php:7.4-fpm
RUN set -eux; apt-get update && apt-get install -y \
        libfcgi0ldbl libzip-dev libmcrypt-dev \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        default-mysql-client time \
        libpng-dev \
        libpq-dev \
        libedit-dev libsodium-dev libxml2-dev \
        libmemcached-dev zlib1g-dev \
        && pecl install memcached \
        && pecl install redis \
        && docker-php-ext-enable redis memcached \
        && docker-php-ext-configure gd --with-freetype --with-jpeg \
        && docker-php-ext-install -j$(nproc) gd opcache pdo pdo_mysql pdo_pgsql zip

RUN curl -o /usr/local/bin/php-fpm-healthcheck https://raw.githubusercontent.com/renatomefi/php-fpm-healthcheck/master/php-fpm-healthcheck \
    && chmod +x /usr/local/bin/php-fpm-healthcheck
RUN echo 'pm.status_path = /status' >> /usr/local/etc/php-fpm.d/docker.conf
COPY --from=backend-builder /var/www/app/ /opt/drupal/
COPY --from=backend-builder /var/www/app/drush /usr/local/src/drush
RUN ln -s /usr/local/src/drush/drush /usr/bin/drush
RUN chown -R www-data:www-data /opt/drupal/docroot/sites /opt/drupal/docroot/modules /opt/drupal/docroot/themes
RUN rm -r /var/www/html; ln -s /opt/drupal/docroot /var/www/html
RUN mkdir /var/www/html/.keys
WORKDIR /var/www/html
EXPOSE 9000
CMD php-fpm
