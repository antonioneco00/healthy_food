#!/bin/bash
service cron start &
service supervisor start ; supervisorctl reread ; supervisorctl update ; supervisorctl stop all &
/usr/local/bin/docker-php-entrypoint apache2-foreground
