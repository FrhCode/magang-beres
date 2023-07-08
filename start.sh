#!/bin/bash

# hmod 777 start.sh
chmod 777 wait-for-it.sh

echo "Waiting for db"
./wait-for-it.sh database:3306 -t 100
echo "db connedted"

php artisan migrate

php artisan serve --host=0.0.0.0 --port=8000
