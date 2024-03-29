#!/bin/bash

#install ruby & bundler
sudo apt update
sudo apt install -y ruby-full ruby-bundler build-essential

#install mongodb
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
sudo bash -c 'echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2multiverse" > /etc/apt/sources.list.d/mongodb-org-3.2.list'
sudo apt update
sudo apt install -y mongodb-org
sudo systemctl start mongod
sudo systemctl enable mongod

#git clone reddit & bundler install

git clone -b monolith https://github.com/express42/reddit.git
cd reddit && bundle install
puma -d
