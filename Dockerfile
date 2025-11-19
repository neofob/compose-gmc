# Use an official Ubuntu runtime as the base image
FROM python:3.14.0-slim-trixie
LABEL maintainer "tuan t. pham" <tuan@vt.edu>

# Set environment variables for package installation
ENV PKGS="pypy3-venv" DEBIAN_FRONTEND=noninteractive
ENV GMC_USER=gmc
RUN adduser ${GMC_USER}

# Update and upgrade packages, install required dependencies, and pip packages
RUN apt-get -yq update && apt-get dist-upgrade -yq \
    && apt-get -yq install --no-install-recommends ${PKGS}

# Remove unnecessary files to reduce image size
RUN apt-get autoremove -yq \
    && apt-get autoclean \
    && rm -fr /tmp/* /var/lib/apt/lists/*

COPY gmc-service.py /usr/local/bin
COPY requirements.txt /tmp/
USER gmc
RUN python3 -m venv /home/gmc/venv
RUN /home/gmc/venv/bin/python3 -m pip install -r /tmp/requirements.txt
WORKDIR /home/gmc

# Expose port 2380 for the application
EXPOSE 2380

# Run the temper-service.py script as the entrypoint
ENTRYPOINT ["/home/gmc/venv/bin/python3", "/usr/local/bin/gmc-service.py"]
