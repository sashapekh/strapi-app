current_directory := $(shell pwd)

include $(current_directory)/.env

DOCKER_COMPOSE = docker compose -f docker-compose.dev.yml --env-file=$(current_directory)/.env

up: 
	${DOCKER_COMPOSE} up -d

build_no_cache:
	${DOCKER_COMPOSE} build --no-cache

build:
	${DOCKER_COMPOSE} build

down:
	${DOCKER_COMPOSE} down