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

FROM nginx:1.21.1-alpine
COPY --from=backend-builder /var/www/app/ /opt/drupal/
RUN mkdir /var/www; ln -s /opt/drupal/docroot /var/www/html
