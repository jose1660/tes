chat: 
	$(MAKE) clear
	$(MAKE) mysql
	docker build -t ahorasi2 .
	sh run-docker2.sh
	sleep 3
	docker logs -f ChatOps_Slack

chatsolo:
	docker stop ChatOps_Slack && docker rm ChatOps_Slack
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

mysql:
	  docker run --name my-remedy-mysql -e MYSQL_ROOT_PASSWORD=antonio -d mysql:8.0.1
	  docker run --name my-remedy-phpmyadmin -d --link my-remedy-mysql:db -p 8081:80 phpmyadmin/phpmyadmin
