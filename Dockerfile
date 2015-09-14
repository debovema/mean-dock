FROM	ubuntu:latest

RUN     apt-get -y install sudo curl git mongodb
RUN     curl -sL https://deb.nodesource.com/setup | sudo bash -
RUN     apt-get update
RUN     apt-get -y install nodejs

RUN     npm install -g mongodb
RUN     npm install -g gulp

# create user 'mean'
RUN useradd -ms /bin/bash mean && adduser mean sudo

# Install app dependencies
RUN mkdir /mean && cd /mean; npm install -g mean-cli

#USER mean
#WORKDIR /mean