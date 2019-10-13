chat:
	docker container stop $(DOCKER_CONTAINER_LIST)
	docker container rm $(DOCKER_CONTAINER_LIST)
	docker build -t ahorasi2 .
	sh run-docker2.sh
	sleep 3
	docker logs -f ChatOps_Slack

DOCKER_CONTAINER_LIST := $(shell docker ps -a -q)

DOCKER_CONTAINER_LIST_RUN := $(shell docker ps -q)
 
clear:
	docker container stop $(DOCKER_CONTAINER_LIST)
	docker container rm $(DOCKER_CONTAINER_LIST)

run:
	sh run-docker2.sh
	sleep 3
