# AnonSurf Multi-Platform Packaging Guide

This document explains the packaging process for AnonSurf Multi-Platform for different Linux distributions.

## Automated Packaging Script

The `build-all-packages.sh` script can be run on any Linux distribution and automatically creates three different package formats (.deb, .rpm, and .pkg.tar.zst). This script performs the build process for all package formats simultaneously, regardless of which distribution you are using.

### Usage

1. Make the script executable:
   ```bash
   chmod +x build-all-packages.sh
   ```

2. Run the script:
   ```bash
   ./build-all-packages.sh
   ```

3. When the process is complete, the following packages will be created in the `packages` directory:
   - `anonsurf-multiplatform_1.0.0-1_amd64.deb` (Debian/Ubuntu)
   - `anonsurf-multiplatform-1.0.0-1.fc38.x86_64.rpm` (Fedora/RHEL/CentOS)
   - `anonsurf-multiplatform-1.0.0-1-x86_64.pkg.tar.zst` (Arch Linux)

## Package Structure

The generated packages will contain the following files:

```
/usr/bin/anonsurf                          # CLI tool
/usr/sbin/anonsurfd                        # Daemon executable
/usr/lib/anonsurf/anonsurf_gtk_vala.so     # GUI library
/usr/lib/anonsurf/anondaemon               # AnonSurf Tor wrapper script
/usr/lib/anonsurf/safekill                 # Application termination script
/usr/share/applications/anonsurf-gtk.desktop # Application launcher
/etc/anonsurf/torrc.base                   # Base Tor configuration
/usr/lib/systemd/system/anonsurfd.service  # Systemd service
/var/lib/anonsurf/                         # Runtime data directory
```

## Manual Packaging

Below are manual packaging steps for each distribution.

### Debian/Ubuntu (.deb)

```bash
# Install required packages
sudo apt-get update
sudo apt-get install -y devscripts debhelper nim valac libgtk-3-dev libnotify-dev

# Go to the project root directory
cd anonsurf-multiplatform

# Create source tarball
cd ..
tar -czf anonsurf-multiplatform_1.0.0.orig.tar.gz anonsurf-multiplatform
cd anonsurf-multiplatform

# Build the package
debuild -us -uc

# The .deb package will be created in the parent directory
```

### Fedora/RHEL/CentOS (.rpm)

```bash
# Install required packages
sudo dnf install -y rpm-build nim vala gtk3-devel libnotify-devel
# or
sudo yum install -y rpm-build nim vala gtk3-devel libnotify-devel

# Create RPM build directory
mkdir -p ~/rpmbuild/{BUILD,RPMS,SOURCES,SPECS,SRPMS}

# Copy the spec file
cp packaging/rpm/anonsurf-multiplatform.spec ~/rpmbuild/SPECS/

# Create source tarball
cd ..
tar -czf ~/rpmbuild/SOURCES/anonsurf-multiplatform-1.0.0.tar.gz anonsurf-multiplatform

# Build the package
rpmbuild -ba ~/rpmbuild/SPECS/anonsurf-multiplatform.spec

# The RPM package will be in ~/rpmbuild/RPMS/{your_architecture}/ directory
```

### Arch Linux (.pkg.tar.zst)

```bash
# Install required packages
sudo pacman -S --needed base-devel nim vala gtk3

# Create build directory
mkdir -p build-arch && cd build-arch

# Copy PKGBUILD file
cp ../packaging/arch/PKGBUILD .

# Create source tarball
cd ..
tar -czf build-arch/anonsurf-multiplatform-1.0.0.tar.gz anonsurf-multiplatform

# Build the package
cd build-arch
makepkg -s

# The package will be created in the current directory
```

## Dependencies

- tor: Tor anonymity network
- iptables: IP packet filtering framework
- gtk3: GTK+ 3 libraries (for GUI)
- systemd: System and service manager
- Optional: nyx (Tor monitoring), bleachbit (system cleaner) 