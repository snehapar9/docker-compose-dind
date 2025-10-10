#!/bin/bash -x

apt-get update
apt-get install -y ca-certificates curl iproute2 git

# Installing tzdata requires interaction later.. let's set it up correctly in first place
export TZ=Etc/UTC
DEBIAN_FRONTEND=noninteractive apt-get -y install tzdata

# Add Docker's official GPG key:
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update

# Install all tools
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-model-plugin

cd /tmp
git clone https://github.com/docker/compose-for-agents.git