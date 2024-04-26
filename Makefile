MAKEFLAGS += --silent

ifneq (,$(wildcard .env))
	include .env
endif

ifndef ENV
	ENV=dev
endif

# Executable
WORKSPACE:=$(shell pwd)
UID:=$(shell id -u)

DOCKER_COMPOSE_FILE=${WORKSPACE}/docker/compose/docker-compose.yml
CMD_DOCKER_COMPOSE=docker-compose -f ${DOCKER_COMPOSE_FILE} --project-directory ${WORKSPACE} ## Point docker to directory's root to find env file

CORE_CLI=$(CMD_DOCKER_COMPOSE) exec --user www-data core
CORE_CLI_ROOT=$(CMD_DOCKER_COMPOSE) exec core

ifneq ($(ENV),dev)
	COMPOSERARG?=--no-dev
endif

export WORKSPACE
export UID

install: ## Install project dependencies
	$(info --> Install for ENV: ${ENV})
	cp ./env/.env.$(ENV).dist ./.env
ifeq ($(PROJECT_TYPE),web)
	make generate-certificate
	make nginx-config
endif
	make up

generate-certificate: ## generate certificate SSL for $(HOST) domain
	sh ./docker/scripts/install/generate-certificate.sh $(HOST)

nginx-config: ## generate nginx config file
	sh ./docker/scripts/install/generate-nginx-config.sh $(HOST)

up: ## docker-compose up -d with good env variables
	$(CMD_DOCKER_COMPOSE) up -d

build: ## docker-compose build
	$(CMD_DOCKER_COMPOSE) build --no-cache

stop: ## docker-compose stop
	$(CMD_DOCKER_COMPOSE) --profile debug --profile build stop

php-install-dependencies: ## Composer install
	$(CORE_CLI) composer install $(COMPOSERARG)

ssh-core: ## Ssh into php container (www-data)
	$(CORE_CLI) sh