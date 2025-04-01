#!/bin/bash
# Setup script for RPM-based distributions (Fedora, RHEL, CentOS, etc.)

# Get the directory of the script
DESTDIR="$1"

# Check which package manager is available
if command -v dnf >/dev/null 2>&1; then
    # Fedora, newer RHEL/CentOS
    echo "Installing Fedora/DNF package dependencies..."
    dnf install -y tor iptables systemd bleachbit libnotify dnsmasq
    
    # Torsocks may be in EPEL for some distributions
    dnf install -y torsocks || dnf install -y epel-release && dnf install -y torsocks
    
    # Nyx may need to be installed via pip
    if ! dnf install -y nyx 2>/dev/null; then
        echo "Installing Nyx via pip..."
        dnf install -y python3-pip
        pip3 install nyx
    fi
elif command -v yum >/dev/null 2>&1; then
    # Older RHEL/CentOS
    echo "Installing RHEL/CentOS/YUM package dependencies..."
    yum install -y tor iptables systemd bleachbit libnotify dnsmasq
    
    # Torsocks may be in EPEL for some distributions
    yum install -y torsocks || yum install -y epel-release && yum install -y torsocks
    
    # Nyx may need to be installed via pip
    echo "Installing Nyx via pip..."
    yum install -y python3-pip
    pip3 install nyx
fi

# Create directories if they don't exist
mkdir -p ${DESTDIR}/etc/network
mkdir -p ${DESTDIR}/etc/tor
mkdir -p ${DESTDIR}/var/lib/tor

# In Fedora/RHEL, the Tor user might be different
if id "toranon" &>/dev/null; then
    TOR_USER="toranon"
elif id "tor" &>/dev/null; then
    TOR_USER="tor"
else
    echo "WARNING: Could not determine Tor user, using 'tor' as default"
    TOR_USER="tor"
fi

# Set correct permissions for Tor directories
chown -R ${TOR_USER}:${TOR_USER} ${DESTDIR}/var/lib/tor/

# Set up Tor service to start at boot
systemctl enable tor.service

echo "RPM-specific setup completed."
exit 0 