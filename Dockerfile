FROM php:5-apache

RUN apt-get update \
  && apt-get install -y \
    git \
    ssl-cert \
    libssl-dev \
    mysql-client \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libpng12-dev \
    zlib1g-dev \
  --no-install-recommends && rm -r /var/lib/apt/lists/*

RUN apt-get update \
  && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
  && docker-php-ext-install \
    gd \
    zip \
    iconv \
    mcrypt \
    mbstring \
    ftp \
    pdo_mysql \
    mysql \
    mysqli

# Xdebug
RUN pecl install xdebug
RUN docker-php-ext-enable xdebug

# Document Rootの設定
RUN sed -i 's#/var/www/html#/var/www/public#' /etc/apache2/apache2.conf

# 設定ファイルの設置
ADD conf.d/vhost.conf /etc/apache2/sites-enabled/000-default.conf
ADD conf.d/ssl-default.conf /etc/apache2/sites-enabled/ssl-default.conf
ADD conf.d/php.ini /usr/local/etc/php/php.ini
ADD conf.d/xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini

# composer command setup
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

ENV HOME /root
ENV PATH $HOME/.composer/vendor/bin:$PATH

# mod_rewrite enabled
RUN a2enmod rewrite

# mod_ssl enabled
RUN a2enmod ssl

EXPOSE 80
EXPOSE 443

# user id changed
RUN usermod -u 1000 www-data
