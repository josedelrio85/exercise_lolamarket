FROM php:fpm-stretch

RUN apt-get update && apt-get install -y \
        git \
        zlib1g-dev \
        libxml2-dev \
        libzip-dev \
    && docker-php-ext-install \
        zip \
        intl \
		mysqli \
        pdo pdo_mysql 
    
RUN curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer
COPY symfony/ /var/www/symfony
WORKDIR /var/www/symfony/
RUN echo "Finishing installing Symfony..."
