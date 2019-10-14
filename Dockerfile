FROM node:latest
RUN apt-get update && \
    apt-get install -y vim mysql-client curl htop apt-transport-https
RUN npm install -g yo generator-hubot coffeescript && mkdir /hubot && chown node:node /hubot
USER node
WORKDIR /hubot
COPY consultas.sh consultas.sh
RUN npm install hubot-scripts && npm install coffee-errors hubot-slack --save && yo hubot --owner="Antonio Kalde <jose1660@gmail.com>" --name="Remedy" --description="Remedy Slack" --adapter="slack" --defaults
ADD scripts /hubot/scripts
CMD HUBOT_SLACK_TOKEN=${HUBOT_SLACK_TOKEN} ./bin/hubot --adapter slack