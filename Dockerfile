FROM alpine:latest

RUN apk add --no-cache git gcc make musl-dev autoconf automake libtool ninja \
  linux-headers bash meson cmake pkgconfig libcap-static libcap-dev libselinux-dev libxslt

RUN git clone https://github.com/ruanformigoni/bubblewrap

WORKDIR bubblewrap

RUN meson build

RUN ninja -C build bwrap.p/bubblewrap.c.o bwrap.p/bind-mount.c.o bwrap.p/network.c.o bwrap.p/utils.c.o

WORKDIR build

RUN cc -o bwrap bwrap.p/bubblewrap.c.o bwrap.p/bind-mount.c.o bwrap.p/network.c.o bwrap.p/utils.c.o -static -L/usr/lib -lcap -lselinux
