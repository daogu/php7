FROM php:7-fpm

RUN echo "Asia/Shanghai" > /etc/timezone
RUN \
    apt-get update && \
    apt-get install -y libwebp-dev git libjpeg62-turbo-dev libpng12-dev libfreetype6-dev libmcrypt-dev libssl-dev

RUN \
    docker-php-ext-configure pdo_mysql && \
    docker-php-ext-configure opcache && \
    docker-php-ext-configure exif && \
    docker-php-ext-configure gd \
    --with-webp-dir=/usr/include --with-png-dir=/usr/include --with-jpeg-dir=/usr/include --with-freetype-dir=/usr/include && \
    docker-php-ext-configure sockets && \
    docker-php-ext-configure mcrypt

RUN \
    pecl install redis && \
    pecl install mongodb && \
    pecl install xdebug && \
    pecl install swoole && \
    pecl clear-cache

RUN \
    docker-php-ext-install zip mbstring pdo_mysql opcache exif gd sockets mcrypt && \
    docker-php-ext-enable redis.so && \
    docker-php-ext-enable mongodb.so && \
    docker-php-ext-enable xdebug.so && \
    docker-php-ext-enable swoole.so && \
    docker-php-source delete && \
    apt-get clean && \
    rm -rf /var/lib/apt/list/*
