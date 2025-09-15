# Use Alpine 3.22 as specified in the Mailcow documentation.
FROM alpine:3.22

# --- Install Mailcow Prerequisites and Docker Management Tools ---
# Combined RUN instruction for efficiency and reduced layer count.
RUN apk update && \
    apk add --no-cache \
    bash \
    coreutils \
    curl \
    findutils \
    gawk \
    git \
    grep \
    jq \
    openssl \
    sed \
    nano \
    \
    # Docker V2 (Compose Plugin) Management Tools
    docker-cli \
    docker-cli-compose && \
    \
    # Clean up package cache to minimize image size
    rm -rf /var/cache/apk/*

# Set the working directory where all Mailcow files will reside.
WORKDIR /opt/mailcow-dockerized

# Clone the Mailcow repository. This provides the compose files and scripts
# that the manager container will use to deploy the actual mail stack.
RUN git clone https://github.com/mailcow/mailcow-dockerized.git .

# Set a default command (to be overridden by the docker-compose.yml 'command'
# to ensure the container stays running).
CMD ["/bin/bash"]