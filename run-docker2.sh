#!/bin/bash

# This is just an example on how we can run hubot with docker.

export HUBOT_SLACK_TOKEN=xoxb-435859165350-781344934096-YzGBYmVlcRQzp8qECdKsVJuq

docker run \
  -e "HUBOT_SLACK_TOKEN=$HUBOT_SLACK_TOKEN" \
  -p 369:8080 \
  -d --link my-remedy-mysql:dbremedy \
  -td --name ChatOps_Slack \
  ahorasi2