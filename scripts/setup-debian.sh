#!/bin/bash
# Setup script for Debian-based distributions (Debian, Ubuntu, Linux Mint, etc.)

# Get the directory of the script
DESTDIR="$1"

# Install apt dependencies
echo "Installing Debian package dependencies..."
apt-get update
apt-get install -y tor iptables systemd bleachbit libnotify-bin nyx torsocks dnsmasq

# Create directories if they don't exist
mkdir -p ${DESTDIR}/etc/network
mkdir -p ${DESTDIR}/etc/tor
mkdir -p ${DESTDIR}/var/lib/tor

# Set correct permissions for Tor directories
chown -R debian-tor:debian-tor ${DESTDIR}/var/lib/tor/

# Set up Tor service to start at boot
systemctl enable tor.service

echo "Debian-specific setup completed."
exit 0 