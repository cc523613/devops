FROM php:5.6.40-apache-stretch

# install the PHP extensions we need
RUN apt-get update && apt-get install -y \
                libfreetype6-dev \
                libjpeg62-turbo-dev \
                libmcrypt-dev \
                libpng-dev \
                imagemagick \
        && docker-php-ext-install -j$(nproc) iconv mcrypt \
        && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
        && docker-php-ext-install -j$(nproc) gd mbstring pdo pdo_mysql  \
        && rm -rf /var/lib/apt/lists/*

COPY / /var/www/html/
RUN chown -R www-data:www-data /var/www/html  && a2enmod rewrite

EXPOSE 80
CMD ["apache2-foreground"]
