FROM php:7.4-cli

WORKDIR /app

COPY --from=composer:2.1.8 /usr/bin/composer /usr/bin/composer

COPY composer.json .

RUN apt-get update && apt-get install -y git
RUN apt-get update && apt-get install -y \
  zlib1g-dev \
  libzip-dev \
  unzip
RUN docker-php-ext-install zip
RUN docker-php-ext-install mysqli pdo pdo_mysql



RUN composer install --no-scripts --no-autoloader

COPY . .
COPY AuthenticatesUsers.php  ./vendor/laravel/ui/auth-backend/

RUN composer update


CMD [ "./start.sh" ]