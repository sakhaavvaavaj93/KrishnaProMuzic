# 1. Use the specific stable image for 2026
FROM python:3.13-slim

# 2. Suppress debconf warnings during the build phase only
ARG DEBIAN_FRONTEND=noninteractive

# 3. Install git and system dependencies in a single layer
# Combinining updates, installs, and cleanup minimizes image size (~71MB saved)
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    apt-utils \
    git \
    && rm -rf /var/lib/apt/lists/*

# 4. Set the working directory
WORKDIR /app

# 5. Copy and install Python requirements
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 6. Copy the rest of the application
COPY . .

# 7. Start the application
CMD ["bash", "start"]

