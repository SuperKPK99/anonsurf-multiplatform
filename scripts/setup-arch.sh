#!/bin/bash
# Setup script for Arch-based distributions (Arch Linux, Manjaro, etc.)

# Get the directory of the script
DESTDIR="$1"

# Install pacman dependencies
echo "Installing Arch package dependencies..."
pacman -Sy --noconfirm tor iptables systemd bleachbit libnotify torsocks dnsmasq 

# AUR dependencies - can't install these directly, notify user
echo "NOTE: You may need to manually install these AUR packages:"
echo "- nyx (Tor network monitor)"

# Create directories if they don't exist
mkdir -p ${DESTDIR}/etc/network
mkdir -p ${DESTDIR}/etc/tor
mkdir -p ${DESTDIR}/var/lib/tor

# Set correct permissions for Tor directories
chown -R tor:tor ${DESTDIR}/var/lib/tor/

# Set up Tor service to start at boot
systemctl enable tor.service

echo "Arch-specific setup completed."
exit 0 