#!/bin/bash

echo "Waiting for db"
./wait-for-it.sh database:3306 -t 100
echo "db connedted"

cp .env.example .env

php artisan migrate:fresh --seed

php artisan serve --host=0.0.0.0 --port=8000