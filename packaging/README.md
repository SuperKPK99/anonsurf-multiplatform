# AnonSurf Multi-Platform Packaging

This directory contains packaging files for various Linux distributions. These files are used to build distribution-specific packages for AnonSurf Multi-Platform.

## Package Build Instructions

### Debian/Ubuntu (.deb)

To build a Debian package:

```bash
# Install build dependencies
sudo apt-get install devscripts debhelper nim valac libgtk-3-dev libnotify-dev

# Go to project root
cd ..

# Create tarball
tar -czf ../anonsurf-multiplatform_1.0.0.orig.tar.gz .

# Build package
debuild -us -uc

# The .deb package will be created in the parent directory
```

### Fedora/RHEL/CentOS (.rpm)

To build an RPM package:

```bash
# Install build dependencies
sudo dnf install rpm-build nim vala gtk3-devel libnotify-devel

# Create build directory
mkdir -p ~/rpmbuild/{BUILD,RPMS,SOURCES,SPECS,SRPMS}

# Copy spec file
cp packaging/rpm/anonsurf-multiplatform.spec ~/rpmbuild/SPECS/

# Create source tarball
cd ..
tar -czf ~/rpmbuild/SOURCES/anonsurf-multiplatform-1.0.0.tar.gz anonsurf-multiplatform

# Build the package
rpmbuild -ba ~/rpmbuild/SPECS/anonsurf-multiplatform.spec

# The RPM will be in ~/rpmbuild/RPMS/{arch}/
```

### Arch Linux (.pkg.tar.zst)

To build an Arch Linux package:

```bash
# Install build dependencies
sudo pacman -S base-devel nim vala gtk3

# Create a build directory
mkdir -p build-arch && cd build-arch

# Copy PKGBUILD
cp ../packaging/arch/PKGBUILD .

# Create source tarball
cd ..
tar -czf build-arch/anonsurf-multiplatform-1.0.0.tar.gz .

# Build the package
cd build-arch
makepkg -si

# The package will be created in the current directory
```

## Package Structure

The packages will install files in the following locations:

```
/usr/bin/anonsurf                          # CLI tool
/usr/sbin/anonsurfd                        # Daemon executable
/usr/lib/anonsurf/anonsurf_gtk_vala.so     # GUI library
/usr/lib/anonsurf/anondaemon               # AnonSurf Tor wrapper script
/usr/lib/anonsurf/safekill                 # Script to kill applications
/usr/share/applications/anonsurf-gtk.desktop # Application launcher
/etc/anonsurf/torrc.base                   # Base Tor configuration
/usr/lib/systemd/system/anonsurfd.service  # Systemd service
/var/lib/anonsurf/                         # Runtime data directory
```

## Dependencies

- tor: Tor anonymity network
- iptables: IP packet filtering framework
- gtk3: GTK+ 3 libraries (for GUI)
- systemd: System and service manager
- Optional: nyx (Tor monitor), bleachbit (system cleaner) 