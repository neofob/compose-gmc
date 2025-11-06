# Use an official Ubuntu runtime as the base image
FROM ubuntu:24.04
LABEL maintainer "tuan t. pham" <tuan@vt.edu>

# Set environment variables for package installation
ENV PKGS="python3 python3-pip python3.12-venv" \
    DEBIAN_FRONTEND=noninteractive

# Update and upgrade packages, install required dependencies, and pip packages
RUN apt-get -yq update && apt-get dist-upgrade -yq \
    && apt-get -yq install --no-install-recommends ${PKGS}

# Remove unnecessary files to reduce image size
RUN apt-get autoremove -yq \
    && apt-get autoclean \
    && rm -fr /tmp/* /var/lib/apt/lists/*

COPY gmc-service.py /usr/local/bin
COPY requirements.txt /tmp/
USER ubuntu
RUN python3 -m venv /home/ubuntu/venv
RUN /home/ubuntu/venv/bin/python3 -m pip install -r /tmp/requirements.txt
WORKDIR /home/ubuntu

# Expose port 2380 for the application
EXPOSE 2380

# Run the temper-service.py script as the entrypoint
ENTRYPOINT ["/home/ubuntu/venv/bin/python3", "/usr/local/bin/gmc-service.py"]
