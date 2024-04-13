docker exec -it wozzby_app composer install
docker exec -it wozzby_app php artisan migrate
docker exec -it wozzby_app bash -c "chmod -R 777 /var/www/html/storage /var/www/html/bootstrap/cache"
