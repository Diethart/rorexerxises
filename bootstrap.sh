#!/usr/bin/env bash

sudo apt-get update
sudo apt-get -y install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
sudo apt-get install libgdbm-dev libncurses5-dev automake libtool bison libffi-dev
curl -L https://get.rvm.io | bash -s stable
source ~/.rvm/scripts/rvm
rvm install 2.3.0
rvm use 2.3.0 --default
ruby -v
gem install bundler
sudo sh -c "echo 'deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main' > /etc/apt/sources.list.d/pgdg.list"
wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | sudo apt-key add -
sudo apt-get update
sudo apt-get -y install nodejs
sudo apt-get -y install postgresql-common
sudo apt-get -y install postgresql-9.5 libpq-dev
sudo -u postgres psql -c "CREATE ROLE diethart WITH SUPERUSER LOGIN PASSWORD 'Gfifhiuh4334'"
sudo -u root sed -i -- '/postgres/!s/peer/md5/' /etc/postgresql/9.5/main/pg_hba.conf
sudo service postgresql restart
cd /vagrant
bundle install
rake db:create
rake db:migrate
