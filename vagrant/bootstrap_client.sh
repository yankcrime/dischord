#!/bin/bash
# Bootstrap a Vagrant instance ready for Puppetizing

# Exit if the following file exists
test -f /root/.provisioned && exit 0

# Distribution-specific package considerations
if [ -f /etc/redhat-release ]; then
  yum makecache fast > /dev/null
  gem install --no-rdoc --no-ri hiera-eyaml > /dev/null
  sed -i '/Defaults    requiretty/d' /etc/sudoers
else
  apt-get update &> /dev/null
  for i in git ruby-json ruby-dev; do
    dpkg -s ${i} &> /dev/null || apt-get -y install ${i} > /dev/null
  done
  for i in librarian-puppet hiera-eyaml; do
    gem query --name ${i} --installed &> /dev/null || gem install --no-rdoc --no-ri ${i} > /dev/null
  done
fi

# 260-character limit on filenames in shared folders can cause problems
# See https://github.com/rodjek/librarian-puppet/issues/256 - plagues OS X and Windows
# Set librarian-puppet's tmp folder to be somewhere other than a share
librarian-puppet config tmp /home/vagrant/.tmp --global && chown vagrant:vagrant /home/vagrant/.tmp

# Done provisioning
touch /root/.provisioned

# Install pre-requisite modules
cd /vagrant && librarian-puppet install
