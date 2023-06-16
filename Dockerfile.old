FROM php:7.4-cli

WORKDIR /app

COPY --from=composer:2.1.8 /usr/bin/composer /usr/bin/composer

RUN apt-get update && apt-get install -y git
RUN apt-get update && apt-get install -y \
	zlib1g-dev \
	libzip-dev \
	unzip \
	dos2unix 

RUN docker-php-ext-install zip
RUN docker-php-ext-install mysqli pdo pdo_mysql


COPY composer.json .
RUN composer install --no-scripts --no-autoloader

COPY . .
COPY AuthenticatesUsers.php  ./vendor/laravel/ui/auth-backend/

RUN composer update

RUN chmod 777 start.sh
RUN chmod 777 wait-for-it.sh

RUN dos2unix /app/start.sh
RUN dos2unix /app/wait-for-it.sh

CMD [ "./start.sh" ]