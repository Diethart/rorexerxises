#!/usr/bin/env bash

sudo apt-get update
sudo gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
sudo apt-get --assume-yes install curl
sudo apt-get --assume-yes install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev
sudo apt-get --assume-yes install libgdbm-dev libncurses5-dev automake libtool bison libffi-dev
\curl -sSL https://get.rvm.io | bash
sudo source ~/.rvm/scripts/rvm
rvm install 2.3.0
rvm use 2.3.0 --default
ruby -v
gem install bundler
gem install rails -v 4.2.6
sudo apt-get --assume-yes install postgresql-common
sudo apt-get --assume-yes install postgresql-9.5 libpq-dev
sudo su postgres -c "psql -c \"CREATE ROLE diethart SUPERUSER LOGIN PASSWORD 'Gfifhiuh4334'\" "
cd /vagrant
bundle install
rake db:create
rake db:migrate
bundle exec puma

