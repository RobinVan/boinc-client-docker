FROM ubuntu:18.04

LABEL maintainer="BOINC" \
      description="A base container image for lightweight BOINC clients" \
      boinc-version="7.14.2"

# Global environment settings
ENV DEBIAN_FRONTEND="noninteractive" \
    BOINC_GUI_RPC_PASSWORD="123" \
    BOINC_REMOTE_HOST="127.0.0.1" \
    BOINC_CMD_LINE_OPTIONS=""

# Copy files
COPY bin/ /usr/bin/

# Configure
WORKDIR /var/lib/boinc

# BOINC RPC port
EXPOSE 31416

# Install
RUN apt-get update && apt-get install -y --no-install-recommends \
# Install PPA dependency
    software-properties-common && \
# Install BOINC Client
    add-apt-repository -y ppa:costamagnagianfranco/boinc && \
    apt-get update && apt-get install -y --no-install-recommends \
    boinc-client && \
# Cleaning up
    apt-get remove -y software-properties-common && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

CMD ["start-boinc.sh"]
