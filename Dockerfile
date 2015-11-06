# Test the deployment a bit.
FROM debian:latest

# Cheat a bit for now by preinstalling deploy-here packages:
RUN apt-get update -y && \
    apt-get install -y \
            build-essential \
            python \
            python-dev \
            python-virtualenv \
            sudo

RUN adduser --disabled-password --gecos '' zcbbot
RUN echo 'export PATH=$HOME/venv/bin:/usr/bin:/bin' > ~zcbbot/.bashrc
RUN sudo -u zcbbot --login virtualenv ~zcbbot/venv
RUN sudo -u zcbbot --login pip install buildbot
RUN sudo -u zcbbot --login buildbot create-master ./bbm
COPY ./master.cfg /home/zcbbot/bbm/
RUN sudo -u zcbbot --login buildbot start ./bbm
RUN sudo -u zcbbot --login \
    buildslave create-slave \
    ./bbs localhost \
    $(cat slave.name) \
    $(cat slave.password)
