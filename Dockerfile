FROM ubuntu:20.04

RUN apt-get update && apt-get install -y \
	software-properties-common

RUN add-apt-repository ppa:ondrej/php
RUN apt-get update && apt-get install -y \
	php7.4 \
	php7.4-mysql \
	php7.4-pdo \
	php7.4-mbstring \
	php7.4-curl \
	php7.4-dom \
	curl \
	unzip
RUN apt install dos2unix 
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

WORKDIR /app

COPY composer.json .
ENV COMPOSER_ALLOW_SUPERUSER=1
RUN composer install --no-scripts --no-autoloader


COPY --chmod=777 . .
COPY AuthenticatesUsers.php  ./vendor/laravel/ui/auth-backend/
RUN composer update

RUN chmod 777 /app/start.sh
RUN chmod 777 /app/wait-for-it.sh

RUN dos2unix /app/start.sh
RUN dos2unix /app/wait-for-it.sh

CMD [ "./start.sh" ]