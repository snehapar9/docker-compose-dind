#!/bin/bash -x

# Remount /proc/sys as read-write
echo "Remounting /proc/sys as read-write..."
mount -o remount,rw /proc/sys

# Enable and start the Docker daemon
echo "Enabling and starting dockerd..."
/usr/bin/dockerd --ipv6=true --ip6tables=true --fixed-cidr-v6=fd00:dead:beef::/48 --rootless > /var/log/dockerd.log 2>&1 &

# Execute the CMD
exec "$@"
