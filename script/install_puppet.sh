#!/bin/bash -eux

# Get release information
# shellcheck disable=SC1091
. /etc/lsb-release

# Configure the Puppet apt repository (DISTRIB_CODENAME is defined in lsb-release)
PUPPET_RELEASE=puppetlabs-release-pc1-$DISTRIB_CODENAME.deb

PUPPET_RELEASE="puppet5-release-${UBUNTU_CODENAME}.deb"

echo "==> Downloading ${PUPPET_RELEASE}"
COUNTER=10
until [[ ${COUNTER} -eq 0 ]]; do
  if wget "http://apt.puppetlabs.com/${PUPPET_RELEASE}"; then
    break
  fi

  (( COUNTER-- ))
done

echo "==> Installing ${PUPPET_RELEASE}"
dpkg -i "${PUPPET_RELEASE}"

echo '==> Updating apt database'
apt-get update

# Install Puppet
echo '==> Installing Puppet'
apt-get -y -q install puppet-agent

echo '==> Installing ruby'
apt-get -y -q install ruby

echo '==> Installing librarian-puppet'
gem install librarian-puppet

# Clean up
echo '==> Cleaning up'
rm -f "${PUPPET_RELEASE}"
