# Levanta la arquitectura

file_selected := -f infrastructure/docker-compose.$(env).yml
environment := $(env)

up:
	@docker-compose $(file_selected) up -d

ps:
	@docker-compose $(file_selected) ps

down:
	@docker-compose $(file_selected) down

build:
	@docker-compose $(file_selected) build $(c)

restart:
	@docker-compose $(file_selected) restart $(c)

logs:
	@docker-compose $(file_selected) logs -f $(c)

logs_php:
	@docker-compose $(file_selected) exec -T php tail -f var/logs/$(environment).log

connect:
	@docker-compose $(file_selected) exec $(c) bash

connect_root:
	@docker-compose $(file_selected) exec -u root $(c) bash

install: up install_dependencies install_assets cache_clear update_database

install_dependencies:
	@docker-compose $(file_selected) exec -T php composer install

install_assets:
	@docker-compose $(file_selected) exec -T php php bin/console assets:install

cache_clear: up
	@docker-compose $(file_selected) exec -T php php bin/console cache:clear --env=dev
	@docker-compose $(file_selected) exec -T php php bin/console cache:clear --env=prod
	@docker-compose $(file_selected) exec -T php rm -rf var/cache/dev
	@docker-compose $(file_selected) exec -T php rm -rf var/cache/prod
	@docker-compose $(file_selected) exec -T php chown -R www-data:www-data var/
	@docker-compose $(file_selected) exec -T php chown -R www-data:www-data public/
	@docker-compose $(file_selected) exec -T php chmod 755 -R var/cache

update_database: up
	@docker-compose $(file_selected) exec -T php php bin/console doctrine:migrations:migrate

create_admin_user:
	@docker-compose $(file_selected) exec -T php php bin/console app:create-admin-user --email=$(email) --password=$(password)

start_metrics:
	@docker-compose $(file_selected) exec -T backend php bin/console app:collector:analytics:active-users --fromDate 2022-06-01 --toDate 2022-06-30
	@docker-compose $(file_selected) exec -T backend php bin/console app:collector:analytics:active-users --fromDate 2022-07-01 --toDate 2022-07-31
	@docker-compose $(file_selected) exec -T backend php bin/console app:collector:analytics:active-users --fromDate 2022-08-01 --toDate 2022-08-31
	@docker-compose $(file_selected) exec -T backend php bin/console app:collector:analytics:active-users --fromDate 2022-09-01 --toDate 2022-09-10
	@docker-compose $(file_selected) exec -T backend php bin/console app:collector:analytics:bounce-rate --fromDate 2022-06-01 --toDate 2022-06-30
	@docker-compose $(file_selected) exec -T backend php bin/console app:collector:analytics:bounce-rate --fromDate 2022-07-01 --toDate 2022-07-31
	@docker-compose $(file_selected) exec -T backend php bin/console app:collector:analytics:bounce-rate --fromDate 2022-08-01 --toDate 2022-08-31
	@docker-compose $(file_selected) exec -T backend php bin/console app:collector:analytics:bounce-rate --fromDate 2022-09-01 --toDate 2022-09-10
	@docker-compose $(file_selected) exec -T backend php bin/console app:collector:analytics:new-users --fromDate 2022-06-01 --toDate 2022-06-30
	@docker-compose $(file_selected) exec -T backend php bin/console app:collector:analytics:new-users --fromDate 2022-07-01 --toDate 2022-07-31
	@docker-compose $(file_selected) exec -T backend php bin/console app:collector:analytics:new-users --fromDate 2022-08-01 --toDate 2022-08-31
	@docker-compose $(file_selected) exec -T backend php bin/console app:collector:analytics:new-users --fromDate 2022-09-01 --toDate 2022-09-10
	@docker-compose $(file_selected) exec -T backend php bin/console app:collector:analytics:page-views --fromDate 2022-06-01 --toDate 2022-06-30
	@docker-compose $(file_selected) exec -T backend php bin/console app:collector:analytics:page-views --fromDate 2022-07-01 --toDate 2022-07-31
	@docker-compose $(file_selected) exec -T backend php bin/console app:collector:analytics:page-views --fromDate 2022-08-01 --toDate 2022-08-31
	@docker-compose $(file_selected) exec -T backend php bin/console app:collector:analytics:page-views --fromDate 2022-09-01 --toDate 2022-09-10
	@docker-compose $(file_selected) exec -T backend php bin/console app:collector:analytics:podcast-subscribe --fromDate 2022-06-01 --toDate 2022-06-30
	@docker-compose $(file_selected) exec -T backend php bin/console app:collector:analytics:podcast-subscribe --fromDate 2022-07-01 --toDate 2022-07-31
	@docker-compose $(file_selected) exec -T backend php bin/console app:collector:analytics:podcast-subscribe --fromDate 2022-08-01 --toDate 2022-08-31
	@docker-compose $(file_selected) exec -T backend php bin/console app:collector:analytics:podcast-subscribe --fromDate 2022-09-01 --toDate 2022-09-10
	@docker-compose $(file_selected) exec -T backend php bin/console app:collector:analytics:returning-users --fromDate 2022-06-01 --toDate 2022-06-30
	@docker-compose $(file_selected) exec -T backend php bin/console app:collector:analytics:returning-users --fromDate 2022-07-01 --toDate 2022-07-31
	@docker-compose $(file_selected) exec -T backend php bin/console app:collector:analytics:returning-users --fromDate 2022-08-01 --toDate 2022-08-31
	@docker-compose $(file_selected) exec -T backend php bin/console app:collector:analytics:returning-users --fromDate 2022-09-01 --toDate 2022-09-10
	@docker-compose $(file_selected) exec -T backend php bin/console app:collector:analytics:returning-visits --fromDate 2022-06-01 --toDate 2022-06-30
	@docker-compose $(file_selected) exec -T backend php bin/console app:collector:analytics:returning-visits --fromDate 2022-07-01 --toDate 2022-07-31
	@docker-compose $(file_selected) exec -T backend php bin/console app:collector:analytics:returning-visits --fromDate 2022-08-01 --toDate 2022-08-31
	@docker-compose $(file_selected) exec -T backend php bin/console app:collector:analytics:returning-visits --fromDate 2022-09-01 --toDate 2022-09-10
	@docker-compose $(file_selected) exec -T backend php bin/console app:collector:analytics:session-duration-user --fromDate 2022-06-01 --toDate 2022-06-30
	@docker-compose $(file_selected) exec -T backend php bin/console app:collector:analytics:session-duration-user --fromDate 2022-07-01 --toDate 2022-07-31
	@docker-compose $(file_selected) exec -T backend php bin/console app:collector:analytics:session-duration-user --fromDate 2022-08-01 --toDate 2022-08-31
	@docker-compose $(file_selected) exec -T backend php bin/console app:collector:analytics:session-duration-user --fromDate 2022-09-01 --toDate 2022-09-10
	@docker-compose $(file_selected) exec -T backend php bin/console app:collector:analytics:slide-download --fromDate 2022-06-01 --toDate 2022-06-30
	@docker-compose $(file_selected) exec -T backend php bin/console app:collector:analytics:slide-download --fromDate 2022-07-01 --toDate 2022-07-31
	@docker-compose $(file_selected) exec -T backend php bin/console app:collector:analytics:slide-download --fromDate 2022-08-01 --toDate 2022-08-31
	@docker-compose $(file_selected) exec -T backend php bin/console app:collector:analytics:slide-download --fromDate 2022-09-01 --toDate 2022-09-10
	@docker-compose $(file_selected) exec -T backend php bin/console app:collector:analytics:total-users --fromDate 2022-06-01 --toDate 2022-06-30
	@docker-compose $(file_selected) exec -T backend php bin/console app:collector:analytics:total-users --fromDate 2022-07-01 --toDate 2022-07-31
	@docker-compose $(file_selected) exec -T backend php bin/console app:collector:analytics:total-users --fromDate 2022-08-01 --toDate 2022-08-31
	@docker-compose $(file_selected) exec -T backend php bin/console app:collector:analytics:total-users --fromDate 2022-09-01 --toDate 2022-09-10
	@docker-compose $(file_selected) exec -T backend php bin/console app:collector:analytics:unique-slide-download --fromDate 2022-06-01 --toDate 2022-06-30
	@docker-compose $(file_selected) exec -T backend php bin/console app:collector:analytics:unique-slide-download --fromDate 2022-07-01 --toDate 2022-07-31
	@docker-compose $(file_selected) exec -T backend php bin/console app:collector:analytics:unique-slide-download --fromDate 2022-08-01 --toDate 2022-08-31
	@docker-compose $(file_selected) exec -T backend php bin/console app:collector:analytics:unique-slide-download --fromDate 2022-09-01 --toDate 2022-09-10
	@docker-compose $(file_selected) exec -T backend php bin/console app:collector:analytics:video-finished --fromDate 2022-06-01 --toDate 2022-06-30
	@docker-compose $(file_selected) exec -T backend php bin/console app:collector:analytics:video-finished --fromDate 2022-07-01 --toDate 2022-07-31
	@docker-compose $(file_selected) exec -T backend php bin/console app:collector:analytics:video-finished --fromDate 2022-08-01 --toDate 2022-08-31
	@docker-compose $(file_selected) exec -T backend php bin/console app:collector:analytics:video-finished --fromDate 2022-09-01 --toDate 2022-09-10
	@docker-compose $(file_selected) exec -T backend php bin/console app:collector:analytics:video-progress --fromDate 2022-06-01 --toDate 2022-06-30
	@docker-compose $(file_selected) exec -T backend php bin/console app:collector:analytics:video-progress --fromDate 2022-07-01 --toDate 2022-07-31
	@docker-compose $(file_selected) exec -T backend php bin/console app:collector:analytics:video-progress --fromDate 2022-08-01 --toDate 2022-08-31
	@docker-compose $(file_selected) exec -T backend php bin/console app:collector:analytics:video-progress --fromDate 2022-09-01 --toDate 2022-09-10
	@docker-compose $(file_selected) exec -T backend php bin/console app:collector:analytics:video-viewed --fromDate 2022-06-01 --toDate 2022-06-30
	@docker-compose $(file_selected) exec -T backend php bin/console app:collector:analytics:video-viewed --fromDate 2022-07-01 --toDate 2022-07-31
	@docker-compose $(file_selected) exec -T backend php bin/console app:collector:analytics:video-viewed --fromDate 2022-08-01 --toDate 2022-08-31
	@docker-compose $(file_selected) exec -T backend php bin/console app:collector:analytics:video-viewed --fromDate 2022-09-01 --toDate 2022-09-10
	@docker-compose $(file_selected) exec -T backend php bin/console app:collector:analytics:visits --fromDate 2022-06-01 --toDate 2022-06-30
	@docker-compose $(file_selected) exec -T backend php bin/console app:collector:analytics:visits --fromDate 2022-07-01 --toDate 2022-07-31
	@docker-compose $(file_selected) exec -T backend php bin/console app:collector:analytics:visits --fromDate 2022-08-01 --toDate 2022-08-31
	@docker-compose $(file_selected) exec -T backend php bin/console app:collector:analytics:visits --fromDate 2022-09-01 --toDate 2022-09-10

clear_prueba:
	@docker-compose $(file_selected) down
	docker volume rm infrastructure_prueba-tecnica-mysql
	rm -r *