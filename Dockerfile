FROM php:8.3-apache as web

RUN apt-get update && apt-get install -y \
    libzip-dev \
    zip \
    libpq-dev

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install pdo_mysql zip pdo_pgsql

RUN a2enmod rewrite
ENV APACHE_DOCUMENT_ROOT=/var/www/html/public
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/000-default.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf

# Copiar código fuente
COPY . /var/www/html
WORKDIR /var/www/html


RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN composer install

# Instalar Composer y dependencias de proyecto
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# RUN php artisan migrate
# Exponer el puerto 80
# EXPOSE 80
