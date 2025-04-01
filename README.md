# AnonSurf Multi-Platform

AnonSurf Multi-Platform is a comprehensive anonymization tool that routes internet traffic through the Tor network, ensuring privacy and anonymity for users on various Linux distributions.

This is a fork of the original [ParrotSec/anonsurf](https://github.com/ParrotSec/anonsurf) project, enhanced to work seamlessly across multiple Linux distributions.

## Features

- **Cross-Platform Compatibility**: Works on Debian-based, Arch-based, and RPM-based Linux distributions
- **Transparent Tor proxy**: Routes all internet traffic through Tor
- **IP/DNS Leak Protection**: Prevents accidental exposure of your real IP address
- **Simple Interface**: Easy-to-use command-line and GUI interfaces
- **System Service Integration**: Can be enabled/disabled at boot
- **Identity Management**: Change your Tor identity with a single command

## Requirements

- Linux operating system (Debian/Ubuntu, Arch, Fedora/RHEL, etc.)
- Tor package
- For GUI mode: GTK3 environment

## Installation

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

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the GNU GPL v2 License - see the LICENSE file for details.

## Acknowledgments

- Original [ParrotSec AnonSurf](https://github.com/ParrotSec/anonsurf) team
- The Tor Project for their incredible work on online privacy and anonymity
- All contributors to this fork 