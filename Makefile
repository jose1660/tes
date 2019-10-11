chat:
	docker container stop $(DOCKER_CONTAINER_LIST)
	docker container rm $(DOCKER_CONTAINER_LIST)
	docker build -t bot2 .
	sh run-docker.sh
	sleep 3

DOCKER_CONTAINER_LIST := $(shell docker ps -a -q)

DOCKER_CONTAINER_LIST_RUN := $(shell docker ps -q)
 
clear:
	docker container stop $(DOCKER_CONTAINER_LIST)
	docker container rm $(DOCKER_CONTAINER_LIST)
