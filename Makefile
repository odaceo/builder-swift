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
	echo $(DOCKER_PASSWORD) | docker login -u $(DOCKER_USERNAME) --password-stdin
	docker-compose push
.PHONY: push

default: build
