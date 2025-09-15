# Use a specific, recent version of Alpine for reproducible builds.
FROM alpine:3.20

# Combine all package installation, updates, and cleanup into a single RUN layer.
# This reduces image size and leverages the build cache more effectively.
RUN apk add --no-cache \
    bash \
    curl \
    git \
    nano \
    openssl \
    # Installs the Docker CLI
    docker-cli \
    # Installs the v2 Compose plugin for Alpine
    docker-cli-compose

# Set the working directory for all subsequent commands.
WORKDIR /opt/mailcow-dockerized

# Clone the mailcow-dockerized repository. This contains the necessary scripts
# and compose files to manage your Mailcow instance.
RUN git clone https://github.com/mailcow/mailcow-dockerized.git .

# Set a default command. This is overridden by your compose file, but is useful
# for running the container interactively.
CMD ["/bin/bash"]