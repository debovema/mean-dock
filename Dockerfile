FROM	node:4.0.0-wheezy

# using bash instead of sh
RUN		rm /bin/sh && ln -s /bin/bash /bin/sh

# prerequisites (sudo, curl, git...)
RUN     apt-get -y update && apt-get -y install sudo vim procps

# custom repositories & package manager
RUN     curl -sL https://deb.nodesource.com/setup | bash -
RUN		apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10 && echo "deb http://repo.mongodb.org/apt/debian wheezy/mongodb-org/3.0 main" | tee /etc/apt/sources.list.d/mongodb-org-3.0.list

# update repositorires
RUN     apt-get -y update

# install mongodb
RUN     apt-get -y install mongodb-org

RUN     npm install -g mongodb; npm install -g gulp; npm install -g bower

# create user 'mean'
# default password = CA1dpLS/ynPS6
RUN		useradd -d /mean -p CA1dpLS/ynPS6 -ms /bin/bash mean && adduser mean sudo && adduser mean mean

RUN		mkdir /mean/.npm && chown -R mean:mean /mean/.npm

# Install app dependencies
RUN		cd /mean; npm install -g mean-cli

RUN		adduser mongodb mongodb
RUN		mkdir -p /data/db && chown -R mongodb:mongodb /data/db
VOLUME	/data/db

CMD mongod
CMD /bin/bash

USER mean
WORKDIR /mean
