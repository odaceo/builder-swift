build:
	docker-compose build
.PHONY: build

push: build
ifndef DOCKER_USERNAME
	$(error DOCKER_USERNAME is not set)
endif
ifndef DOCKER_PASSWORD
	$(error DOCKER_PASSWORD is not set)
endif
	docker login -u $(DOCKER_USERNAME) -p $(DOCKER_PASSWORD)
	docker-compose push
.PHONY: push

default: build
