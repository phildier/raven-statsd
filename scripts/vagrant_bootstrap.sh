#!/bin/bash -ex

# install chef dev kit. (includes berkshelf, needed below)
if [ ! -f /tmp/chefdk.rpm ]; then
	wget -qO /tmp/chefdk.rpm https://opscode-omnibus-packages.s3.amazonaws.com/el/6/x86_64/chefdk-0.4.0-1.x86_64.rpm
	rpm -Uvh /tmp/chefdk.rpm
fi

yum -y install git

# install 3rd party cookbooks
cd /vagrant
berks vendor --except site
