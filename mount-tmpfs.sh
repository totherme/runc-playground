#!/bin/sh

PATH=/sbin:/usr/sbin:/bin:/usr/bin

do_start() {
  mkdir -p /run/opencontainer/
  mount -t tmpfs runcstate /run/opencontainer
  mkdir -p /run/opencontainer/containers
}

case "$1" in
  start)
    do_start
    ;;
  restart|reload|force-reload)
    echo "Error: argument '$1' not supported" >&2
    exit 3
    ;;
  stop)
    ;;
  *)
    echo "Usage: $0 start|stop" >&2
    exit 3
    ;;
esac
