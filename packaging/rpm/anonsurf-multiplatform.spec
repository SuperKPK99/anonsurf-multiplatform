Name:           anonsurf-multiplatform
Version:        1.0.0
Release:        1%{?dist}
Summary:        Anonymous Mode for Internet - Multi-Platform Version

License:        GPL-2.0
URL:            https://github.com/ibrahimsql/anonsurf-multiplatform
Source0:        %{name}-%{version}.tar.gz

BuildRequires:  nim
BuildRequires:  vala
BuildRequires:  pkgconfig(gtk+-3.0)
Requires:       tor
Requires:       iptables
Requires:       gtk3
Recommends:     nyx
Recommends:     bleachbit
Conflicts:      anonsurf
Provides:       anonsurf

%description
AnonSurf is a tool designed to route all internet traffic
through the Tor network for enhanced anonymity.

This multi-platform version supports:
 * Debian-based systems (Ubuntu, Mint, etc.)
 * Arch-based systems (Manjaro, EndeavourOS, etc.)
 * RPM-based systems (Fedora, RHEL, etc.)
 * Various DNS resolver systems

Features:
 * Transparent Tor proxy
 * DNS leak protection
 * IP leak protection
 * Command-line interface
 * Graphical interface
 * System service integration

%prep
%autosetup

%build
make

%install
rm -rf $RPM_BUILD_ROOT
make install DESTDIR=$RPM_BUILD_ROOT

# Create necessary directories
mkdir -p %{buildroot}/etc/anonsurf
mkdir -p %{buildroot}/var/lib/anonsurf

# Set permissions
chmod 700 %{buildroot}/var/lib/anonsurf

%files
%license LICENSE
%doc README.md
/usr/bin/anonsurf
/usr/sbin/anonsurfd
/usr/lib/anonsurf/anonsurf_gtk_vala.so
/usr/lib/anonsurf/anondaemon
/usr/lib/anonsurf/safekill
/usr/share/applications/anonsurf-gtk.desktop
/etc/anonsurf/torrc.base
/usr/lib/systemd/system/anonsurfd.service
%dir /var/lib/anonsurf

%post
# Update systemd
systemctl daemon-reload

%preun
# Stop anonsurf service if running
if systemctl is-active anonsurfd >/dev/null 2>&1; then
    systemctl stop anonsurfd
fi

# Disable service
if systemctl is-enabled anonsurfd >/dev/null 2>&1; then
    systemctl disable anonsurfd
fi

%postun
systemctl daemon-reload

%changelog
* Tuesday, April 1, 2025 6:57 PM  ibrahimsql ibrahimsql@proton.me - 1.0.0-1
- Initial release of AnonSurf Multi-Platform 