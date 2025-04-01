NIM=/home/ibrahim/.nimble/bin/nim

all: nim_cli gtk_gui launcher

nim_cli:
	mkdir -p build
	cd src/nim/anonsurf && $(NIM) c -d:release -d:ssl --threads:on -o:../../../build/anonsurf AnonSurfCli.nim
	cd src/nim/anonsurf && $(NIM) c -d:release -d:ssl --threads:on -o:../../../build/anonsurfd make_torrc.nim

gtk_gui:
	mkdir -p build
	cd src/vala && $(MAKE) NIM=$(NIM)
	cp src/vala/anonsurf_gtk_vala.so build/ || echo "Vala build failed. Continuing with CLI only..."

test:
	cd src/nim && $(NIM) c -r tests.nim

launcher:
	mkdir -p build/launchers
	cp launchers/anonsurf-gtk.desktop build/launchers/

install:
	# Install binary files
	install -Dm755 build/anonsurf /usr/bin/anonsurf
	install -Dm755 build/anonsurfd /usr/sbin/anonsurfd
	
	# Install GUI if available
	if [ -f build/anonsurf_gtk_vala.so ]; then \
		install -Dm755 build/anonsurf_gtk_vala.so /usr/lib/anonsurf/anonsurf_gtk_vala.so; \
		install -Dm644 launchers/anonsurf-gtk.desktop /usr/share/applications/anonsurf-gtk.desktop; \
	fi
	
	# Install scripts
	install -Dm755 scripts/anondaemon /usr/lib/anonsurf/anondaemon
	install -Dm755 scripts/safekill /usr/lib/anonsurf/safekill
	install -Dm755 scripts/dnschanger-hook /etc/dhcp/dhclient-enter-hooks.d/dnschanger
	
	# Install configurations
	install -Dm644 configs/torrc.base /etc/anonsurf/torrc.base
	
	# Install icons
	install -Dm644 icons/anonsurf.png /usr/share/icons/hicolor/128x128/apps/anonsurf.png
	install -Dm644 icons/status.png /usr/share/icons/hicolor/128x128/apps/anonsurf-status.png
	install -Dm644 icons/about.png /usr/share/icons/hicolor/128x128/apps/anonsurf-about.png
	
	# Install systemd units
	install -Dm644 sys-units/anonsurfd.service /usr/lib/systemd/system/anonsurfd.service
	
	# Make directories
	mkdir -p /var/lib/anonsurf/
	
	# Set permissions
	chmod 700 /var/lib/anonsurf/

uninstall:
	rm -f /usr/bin/anonsurf
	rm -f /usr/sbin/anonsurfd
	rm -f /usr/lib/anonsurf/anonsurf_gtk_vala.so
	rm -f /usr/lib/anonsurf/anondaemon
	rm -f /usr/lib/anonsurf/safekill
	rm -f /etc/dhcp/dhclient-enter-hooks.d/dnschanger
	rm -f /usr/share/applications/anonsurf-gtk.desktop
	rm -f /usr/share/icons/hicolor/128x128/apps/anonsurf.png
	rm -f /usr/share/icons/hicolor/128x128/apps/anonsurf-status.png
	rm -f /usr/share/icons/hicolor/128x128/apps/anonsurf-about.png
	rm -rf /etc/anonsurf
	rm -f /usr/lib/systemd/system/anonsurfd.service
	rm -rf /var/lib/anonsurf

clean:
	rm -rf build/

.PHONY: all nim_cli gtk_gui test launcher install uninstall clean 