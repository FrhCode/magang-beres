#!/bin/bash

# RUN chmod 777 start.sh
RUN chmod 777 wait-for-it.sh

echo "Waiting for db"
./wait-for-it.sh database:3306 -t 100
echo "db connedted"

php artisan migrate:fresh --seed

php artisan serve --host=0.0.0.0 --port=8000
