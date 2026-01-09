FROM python:3.13-slim

# 1. Force the frontend to Noninteractive at the system level
# This silences the "Teletype" and "Dialog" warnings more effectively than ARG alone
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# 2. Use ARG for build-time environment suppression
ARG DEBIAN_FRONTEND=noninteractive

# 3. Install necessary packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    apt-utils \
    git && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY . /app
RUN pip install --no-cache-dir -r requirements.txt
CMD ["bash", "start"]
