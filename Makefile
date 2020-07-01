
CFLAGS_DBUS = $(shell pkg-config --cflags --libs dbus-1)
CFLAGS_DBUS_GLIB = $(shell pkg-config --cflags --libs dbus-glib-1)
CFLAGS_GIO  = $(shell pkg-config --cflags --libs gio-2.0)
CFLAGS_GIO_UNIX  = $(shell pkg-config --cflags --libs gio-unix-2.0)

CFLAGS = -g -Wall -Werror

all: ./build/btspp

profile1-iface.h: btspp.xml
	gdbus-codegen --header --output profile1-iface.h btspp.xml

profile1-iface.c: btspp.xml
	gdbus-codegen --body --output profile1-iface.c btspp.xml

./build/btspp: btspp.c profile1-iface.h profile1-iface.c
	gcc $^ -o $@ $(CFLAGS) $(CFLAGS_DBUS) $(CFLAGS_DBUS_GLIB) $(CFLAGS_GIO) $(CFLAGS_GIO_UNIX)

clean:
	rm -f ./build/btspp

.PHONY: all clean
