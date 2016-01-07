#!/bin/bash
set -e

# non interactive
echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# install system deps
echo " ---> Updating"
apt-get -y -qq --force-yes update
apt-get -y -qq --force-yes install wget sudo

# cleanup
echo " ---> Cleaning up"
apt-get -y -qq --force-yes clean
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# create data, apps and log directory
mkdir /data /apps /apps-dev /logs
chown arangodb:arangodb /data /apps /apps-dev /logs
