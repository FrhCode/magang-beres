#!/bin/bash

echo "Waiting for db"
./wait-for-it.sh database:3306
echo "db connedted"


cp .env.example .env

php artisan key:generate

php artisan down
php artisan cache:clear

php artisan config:clear
php artisan config:cache

php artisan event:clear
php artisan event:cache

php artisan route:clear

php artisan view:clear

php artisan up

php artisan migrate:fresh --seed


php artisan serve --host=0.0.0.0 --port=8000