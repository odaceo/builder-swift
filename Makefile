build:
	docker-compose build
.PHONY: build

push:
	docker-compose push
.PHONY: push

default: build
