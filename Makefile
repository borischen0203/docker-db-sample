container?=docker-mysql

default:
	echo ${container}

.PHONY: docker-up
docker-up:
	@echo "Run docker container - ${container}!"
	docker-compose -f docker-compose.yaml up -d --build

.PHONY: docker-down
docker-down: ## Stop docker containers and clear artefacts.
	@echo "Terminate docker container - ${container}"
	docker-compose -f docker-compose.yaml down
	docker system prune

.PHONY: docker-exec
docker-exec: ## exec container
	@echo "Run docker exec command into container - ${container}"
	docker exec -it ${container} /bin/sh
