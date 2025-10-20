#!/bin/bash -x

# Parse arguments
REPO_URL="$1"
REPO_DIR="$2"

# Remount /proc/sys as read-write
echo "Remounting /proc/sys as read-write..."
mount -o remount,rw /proc/sys

# Enable and start the Docker daemon
echo "Enabling and starting dockerd..."
/usr/bin/dockerd --ipv6=true --ip6tables=true --fixed-cidr-v6=fd00:dead:beef::/48 --rootless > /var/log/dockerd.log 2>&1 &

# Wait for Docker daemon to be ready
echo "Waiting for Docker daemon to be ready..."
while ! docker info > /dev/null 2>&1; do
    echo "Docker daemon not ready yet, waiting..."
    sleep 2
done
echo "Docker daemon is ready!"

# If repository URL and directory are provided, clone and run docker compose
if [ -n "$REPO_URL" ] && [ -n "$REPO_DIR" ]; then
    echo "Cloning repository: $REPO_URL"
    cd /tmp
    git clone "$REPO_URL"
    
    echo "Changing to directory: $REPO_DIR"
    cd "$REPO_DIR"
    
    echo "Running docker compose up..."
    docker compose up
    
    echo "Docker compose services started!"
    docker compose ps
fi

# Keep container running
echo "Container is ready. Keeping it alive..."
tail -f /dev/null
