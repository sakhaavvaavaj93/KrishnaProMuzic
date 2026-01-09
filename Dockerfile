# Use the official Python 3.13 slim image
FROM python:3.13-slim

# Install git and clean up in one single layer
# This ensures git is available in the PATH for GitPython
RUN apt-get update && \
    apt-get install -y --no-install-recommends git && \
    rm -rf /var/lib/apt/lists/*

# Application setup
WORKDIR /app
COPY . /app

# Install Python dependencies (including gitpython)
RUN pip install --no-cache-dir -r requirements.txt

# Start command
CMD ["bash", "start"]
