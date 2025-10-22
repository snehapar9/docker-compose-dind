# Start with an Ubuntu base image
FROM ubuntu:latest

# Install basic dependencies
RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    gnupg \
    lsb-release \
    jq \
    && rm -rf /var/lib/apt/lists/*

# Copy the scripts into the Docker container
COPY install-docker-27.sh /usr/local/bin/install-docker-27.sh
COPY install-act.sh /usr/local/bin/install-act.sh

# Make the scripts executable
RUN chmod +x /usr/local/bin/install-docker-27.sh /usr/local/bin/install-act.sh

# Run the Docker installation script
RUN /usr/local/bin/install-docker-27.sh

# Run the Act installation script
RUN /usr/local/bin/install-act.sh

# Copy the test dockerfile to container
RUN mkdir -p /test
COPY Test.Dockerfile /test/Dockerfile

# Add the seccomp profile into the image
COPY seccomp/docker-compose-seccomp.json /etc/seccomp/docker-compose-seccomp.json

# Copy entrypoint script to the container
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Set the entrypoint
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# Default command
CMD ["/usr/bin/sleep", "inf"]