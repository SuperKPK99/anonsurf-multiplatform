# AnonSurf Multi-Platform

AnonSurf Multi-Platform is a comprehensive anonymization tool that routes internet traffic through the Tor network, ensuring privacy and anonymity for users on various Linux distributions.

## About

> **Privacy is your right, not a privilege**

AnonSurf Multi-Platform is a powerful, cross-distribution anonymization tool that protects your privacy by routing all your internet traffic through the Tor network. It provides a simple yet effective way to maintain anonymity online, defend against surveillance, and access restricted content.

Unlike other Tor routing solutions, AnonSurf Multi-Platform works seamlessly across multiple Linux distributions including Debian-based, Arch-based, and RPM-based systems with a unified codebase and installation process.

This is a fork of the original [ParrotSec/anonsurf](https://github.com/ParrotSec/anonsurf) project, enhanced with cross-platform support and additional features.

[![Turkish Documentation](https://img.shields.io/badge/Türkçe_Dokümantasyon-🇹🇷-red.svg)](README.tr.md)

## Features

- **Cross-Platform Compatibility**: Works on Debian-based, Arch-based, and RPM-based Linux distributions
- **Transparent Tor proxy**: Routes all internet traffic through Tor
- **IP/DNS Leak Protection**: Prevents accidental exposure of your real IP address
- **Simple Interface**: Easy-to-use command-line and GUI interfaces
- **System Service Integration**: Can be enabled/disabled at boot
- **Identity Management**: Change your Tor identity with a single command

## Requirements

### Build Requirements
- Nim compiler (>= 1.6.0)
- libnim-gintro-dev (for GTK GUI)
- GTK3 development libraries
- make
- gcc/clang
- pkg-config

### Runtime Requirements
- Linux operating system (Debian/Ubuntu, Arch, Fedora/RHEL, etc.)
- Tor package
- iptables or nftables
- resolvconf (recommended but not required)
- GTK3 libraries (for GUI mode)

## Installation

### Installing Build Dependencies

#### Debian/Ubuntu
```bash
sudo apt install nim libnim-gintro-dev libgtk-3-dev make gcc pkg-config tor iptables
```

#### Arch Linux
```bash
sudo pacman -S nim gtk3 make gcc pkg-config tor iptables
# Install gintro from AUR
yay -S nim-gintro
```

#### Fedora/RHEL
```bash
sudo dnf install nim gtk3-devel make gcc pkg-config tor iptables
# For gintro, you might need to install via nimble
nimble install gintro
```

### From Source

1. Clone the repository:
```bash
git clone https://github.com/ibrahimsql/anonsurf-multiplatform.git
cd anonsurf-multiplatform
```

2. Build the project:
```bash
make
```

3. Install:
```bash
sudo make install
```

### Distribution-specific packages

#### Debian/Ubuntu
```bash
sudo dpkg -i anonsurf-multiplatform_1.0.0_amd64.deb
sudo apt install -f
```

#### Arch Linux
```bash
sudo pacman -U anonsurf-multiplatform-1.0.0-1-x86_64.pkg.tar.zst
```

#### Fedora/RHEL
```bash
sudo dnf install anonsurf-multiplatform-1.0.0-1.fc38.x86_64.rpm
```

### Building Distribution Packages

To build packages for different distributions:
```bash
./build-all-packages.sh
```

This will create packages in the `build/` directory.

## Usage

### Command Line Interface

```bash
# Check your current IP
anonsurf myip

# Start anonymization
sudo anonsurf start

# Check status
anonsurf status

# Change Tor identity
sudo anonsurf changeid

# Stop anonymization
sudo anonsurf stop

# Enable at boot
sudo anonsurf enable-boot

# Disable at boot
sudo anonsurf disable-boot
```

### Graphical Interface

Launch the GUI application from your application menu or by running:

```bash
anonsurf-gtk
```

## Features Coming Soon

- NetworkManager integration for improved connection management
- OpenVPN integration for additional security layers
- I2P network support for alternative anonymization

## Security Notes

- While AnonSurf provides anonymity, it is not foolproof. Always practice safe browsing habits.
- Do not run untrusted programs while using AnonSurf, as they could potentially bypass the Tor proxy.
- For highest security, consider using Tails or Whonix, which are specifically designed for anonymity.

## Troubleshooting

### DNS Issues
If you experience DNS issues:
```bash
sudo anonsurf stop
sudo nano /etc/resolv.conf  # Change nameserver to 1.1.1.1 or 8.8.8.8
sudo anonsurf start
```

### Network Connectivity Issues
If you cannot connect to any websites after starting AnonSurf:
```bash
sudo anonsurf stop
sudo systemctl restart tor
sudo anonsurf start
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the GNU GPL v2 License - see the LICENSE file for details.

## Acknowledgments

- Original [ParrotSec AnonSurf](https://github.com/ParrotSec/anonsurf) team
- The Tor Project for their incredible work on online privacy and anonymity
- All contributors to this fork 