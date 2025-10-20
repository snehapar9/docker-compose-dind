#!/bin/bash -x

set -e

apt-get update
apt-get install -y ca-certificates curl iproute2 gnupg lsb-release git

# Configure timezone non-interactively
export TZ=Etc/UTC
DEBIAN_FRONTEND=noninteractive apt-get -y install tzdata

# Add Docker’s official GPG key
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc

# Add Docker repository
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update

# Show available versions (for debugging)
apt-cache madison docker-ce | grep 27
apt-cache madison docker-compose-plugin | grep 2.27

# Install pinned Docker 27
apt-get install -y \
  docker-ce=5:27.* \
  docker-ce-cli=5:27.* \
  containerd.io \
  docker-buildx-plugin=0.17.* \
  docker-compose-plugin \
  docker-model-plugin