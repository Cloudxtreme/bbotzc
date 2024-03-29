# For testing the deployment (not for our actual deploy):

FROM debian:latest

# System setup:
RUN apt-get update -y && \
    apt-get install -y \
            build-essential \
            libffi-dev \
            libssl-dev \
            python \
            python-dev \
            python-virtualenv \
            sudo

RUN adduser --disabled-password --gecos '' zcbbot
RUN echo 'export PATH=$HOME/venv/bin:/usr/bin:/bin' > ~zcbbot/.bashrc
RUN sudo -u zcbbot --login virtualenv ~zcbbot/venv
RUN sudo -u zcbbot --login pip install buildbot
RUN sudo -u zcbbot --login pip install buildbot-slave
RUN sudo -u zcbbot --login pip install txgithub
RUN sudo -u zcbbot --login buildbot create-master ./bbm
COPY ./master.cfg /home/zcbbot/bbm/

# Write some dummy secrets:
RUN head -c 10 /dev/urandom | base64 > ~zcbbot/github.status-secret
RUN head -c 10 /dev/urandom | base64 > ~zcbbot/github.webhook-secret
RUN echo '[["user", "password"]]' > ~zcbbot/webcreds.json

# Start the daemons:
RUN sudo -u zcbbot --login buildbot start ./bbm
RUN sudo -u zcbbot --login \
    buildslave create-slave \
    ./bbs localhost \
    'builder-0' \
    $(cat ~zcbbot/slave.password)
