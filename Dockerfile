# 1. Use the specific base image
FROM python:3.13-slim

# 2. Silence debconf by pre-seeding the frontend preference
# This resolves "unable to initialize frontend" warnings by setting a system default
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# 3. Suppress secondary warnings about "TERM not set" and "apt-utils missing"
# We use ARG so these variables don't persist in your final image
ARG DEBIAN_FRONTEND=noninteractive
ARG TERM=linux

# 4. Install git and required utilities in a single layer
# Installing apt-utils early prevents the "delaying package configuration" warning
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    apt-utils \
    git \
    && rm -rf /var/lib/apt/lists/*

# Proceed with application setup
WORKDIR /app
COPY . /app
RUN pip install --no-cache-dir -r requirements.txt
CMD ["bash", "start"]
