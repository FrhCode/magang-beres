FROM php:7.4.33-zts-bullseye

RUN apt update && \
    apt install -y  \
    dos2unix \
    zlib1g-dev \
    libzip-dev \
    default-mysql-client

RUN docker-php-ext-install zip mysqli pdo_mysql

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /app

COPY composer.json .
ENV COMPOSER_ALLOW_SUPERUSER=1
RUN composer install --no-scripts --no-autoloader

COPY . .
COPY AuthenticatesUsers.php  ./vendor/laravel/ui/auth-backend/
RUN composer update

RUN dos2unix start.sh
RUN dos2unix wait-for-it.sh

CMD [ "./start.sh" ]
