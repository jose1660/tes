#!/bin/bash

# This is just an example on how we can run hubot with docker.
export PORT=9999
export EXPRESS_PORT=9999
export HUBOT_SLACK_TOKEN=xoxb-220558913360-384990725124-AXHVoSwavi6nQjVS2701Gbt0
export HUBOT_ADAPTER=slack
export HUBOT_JENKINS_URL=http://ip172-18-0-23-bd3qqsts2ti0008pm780-8080.direct.labs.play-with-docker.com
export HUBOT_JENKINS_AUTH=chatops:09557eb3f90f502fbc305498ce350ff1

docker run \
  -e "HUBOT_SLACK_TOKEN=$HUBOT_SLACK_TOKEN" \
  -e "HUBOT_ADAPTER=$HUBOT_ADAPTER" \
  -e "HUBOT_JENKINS_URL=$HUBOT_JENKINS_URL" \
  -e "HUBOT_JENKINS_AUTH=$HUBOT_JENKINS_AUTH" \
  -p 9999:8080 \
  -td --name ChatOps_Slack \
  bot
