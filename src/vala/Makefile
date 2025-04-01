# AnonSurf Multi-Platform Vala Makefile
# This project is a fork of ParrotSec/anonsurf
# Licensed under GPL-2.0

# Default value for NIM if not provided
NIM?=nim

all:
	mkdir -p build/
	$(NIM) c -d:release --noMain --app:staticlib -o:build/anonsurf.so anonsurf_api.nim
	valac --pkg gtk+-3.0 --pkg libnotify anonsurf_gtk.vala gui/layout_main.vala gui/layout_titlebar.vala gui/dialog_about.vala gui/layout_systray.vala gui/dialog_options.vala gui/window_anonsurf.vala -X build/anonsurf.so -X -I. -o build/anonsurf-gtk
	cp build/anonsurf-gtk anonsurf_gtk_vala.so