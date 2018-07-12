#!/bin/bash

# This is just an example on how we can run hubot with docker.
export PORT=9999
export EXPRESS_PORT=9999
export HUBOT_SLACK_TOKEN=xoxb-220558913360-384990725124-AXHVoSwavi6nQjVS2701Gbt0
export HUBOT_ADAPTER=slack
export HUBOT_JENKINS_URL=http://52.2.27.172:9091
export HUBOT_JENKINS_AUTH=admin:admin

docker run \
  -e "HUBOT_SLACK_TOKEN=$HUBOT_SLACK_TOKEN" \
  -e "HUBOT_ADAPTER=$HUBOT_ADAPTER" \
  -e "HUBOT_JENKINS_URL=$HUBOT_JENKINS_URL" \
  -e "HUBOT_JENKINS_AUTH=$HUBOT_JENKINS_AUTH" \
  -p 9999:8080 \
  -td --name ChatOps_Slack \
  bot2
