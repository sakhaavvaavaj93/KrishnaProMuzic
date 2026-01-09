# Use the desired base image
FROM python:3.13-slim

# Install git using the Debian package manager (apt)
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    && rm -rf /var/lib/apt/lists/*

# Your application setup follows...
COPY . /app
WORKDIR /app
RUN pip install -r requirements.txt
CMD ["bash", "start"]


