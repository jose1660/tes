FROM node:4.4.3-slim

MAINTAINER "Naresh Rayapati" <naresh.rayapati@yahoo.com>



ENV DEBIAN_FRONTEND noninteractive
ENV HUBOT_SLACK_TOKEN nope-1234-5678-91011-00e4dd
ENV HUBOT_NAME myhubot
ENV HUBOT_OWNER none
ENV HUBOT_DESCRIPTION Hubotcat
ENV EXTERNAL_SCRIPTS "hubot-help,hubot-pugme"
ENV HUBOT_BITBUCKET_PULLREQUEST_ROOM=pull-requests
ENV HUBOT_BITBUCKET_PULLREQUEST_ANNOUNCE=created,merged,issue_created,approve,unapprove

ENV HUBOT_GRAFANA_HOST=http://play.grafana.org
ENV HUBOT_GRAFANA_API_KEY=abcd01234deadbeef01234
ENV HUBOT_GRAFANA_QUERY_TIME_RANGE=1h
ENV HUBOT_GRAFANA_S3_BUCKET=mybucket
ENV HUBOT_GRAFANA_S3_ACCESS_KEY_ID=ABCDEF123456XYZ
ENV HUBOT_GRAFANA_S3_SECRET_ACCESS_KEY=aBcD01234dEaDbEef01234
ENV HUBOT_GRAFANA_S3_PREFIX=graphs
ENV HUBOT_SLACK_TOKEN=xoxb-220558913360-384990725124-AXHVoSwavi6nQjVS2701Gbt0

# Install CoffeeScript, Hubot
RUN \
  npm install -g coffee-script hubot yo generator-hubot && \
  rm -rf /var/lib/apt/lists/*

# Make user for Hubot
RUN groupadd -g 501 hubot && \
  useradd -m -u 501 -g 501 hubot

USER hubot
WORKDIR /home/hubot

COPY ["external-scripts.json","package.json","/home/hubot/"]
ADD bin /home/hubot/bin
ADD scripts /home/hubot/scripts

RUN npm install --silent

CMD ["/bin/sh", "-c", "bin/hubot"]
