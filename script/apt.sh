#!/bin/bash -eux

# Disable the release upgrader
echo "==> Disabling the release upgrader"
sed -i.bak 's/^Prompt=.*$/Prompt=never/' /etc/update-manager/release-upgrades

echo '==> Configuring apt'
# Set apt to only resolve IPv4 addresses
echo "Acquire::ForceIPv4 \"true\";" >> /etc/apt/apt.conf.d/99force-ipv4
# Disable periodic updates
echo 'APT::Periodic::Enable "0";' >> /etc/apt/apt.conf.d/10periodic
