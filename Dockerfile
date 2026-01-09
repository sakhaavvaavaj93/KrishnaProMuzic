FROM python:3.12-slim
RUN pip install gitpython
# 1. Pre-seed debconf to force Noninteractive mode at the system level
# This silences the "Dialog" and "Readline" frontend warnings reliably
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# 2. Use build arguments for temporary suppression
ARG DEBIAN_FRONTEND=noninteractive
ARG DEBCONF_NOWARNINGS=yes

# 3. Use an inline environment variable for the installation command
# Installing apt-utils first resolves secondary configuration delays
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    apt-utils \
    git && \
    rm -rf /var/lib/apt/lists/*

# Application setup
WORKDIR /app
COPY . .
RUN pip install --no-cache-dir -r requirements.txt
CMD ["bash", "start"]




