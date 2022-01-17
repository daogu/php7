FROM php:7-fpm

RUN \
    apt-get update && \
    apt-get install -y libwebp-dev git libjpeg62-turbo-dev libpng-dev libfreetype6-dev libmcrypt-dev libssl-dev libzip-dev libonig-dev

RUN \
    docker-php-ext-configure pdo_mysql && \
    docker-php-ext-configure opcache && \
    docker-php-ext-configure gd --with-freetype --with-jpeg && \
    docker-php-ext-configure exif && \
    docker-php-ext-configure sockets

RUN \
    pecl install redis && \
    pecl install mongodb && \
    pecl install xdebug && \
    pecl install swoole && \
    pecl install mcrypt && \
    pecl clear-cache

RUN \
    docker-php-ext-install zip pdo_mysql opcache exif gd sockets && \
    docker-php-ext-enable mcrypt.so && \
    docker-php-ext-enable redis.so && \
    docker-php-ext-enable mongodb.so && \
    docker-php-ext-enable xdebug.so && \
    docker-php-ext-enable swoole.so && \
    docker-php-source delete && \
    apt-get clean && \
    rm -rf /var/lib/apt/list/*